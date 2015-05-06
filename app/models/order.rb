class Order < ActiveRecord::Base
  # get module to help with some functionality
  include BreadExpressHelpers::Validations
  include BreadExpressHelpers::Shipping
  require 'base64'

  # Relationships
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :customer
  belongs_to :address

  # Virtual attributes (non-saved)
  attr_accessor :credit_card_number
  attr_accessor :expiration_year
  attr_accessor :expiration_month

  # Scopes
  scope :chronological, -> { order(date: :desc) }
  scope :paid,          -> { where.not(payment_receipt: nil) }
  scope :for_customer,  ->(customer_id) { where(customer_id: customer_id) }

  # Class methods
  def self.not_shipped
    joins(:order_items).where("order_items.shipped_on IS NULL").uniq!
  end

  # Validations
  validates_date :date
  validates_numericality_of :grand_total, greater_than_or_equal_to: 0, allow_blank: true
  validate :customer_is_active_in_system
  validate :address_is_active_in_system
  validate :credit_card_number_is_valid
  validate :expiration_date_is_valid

  # Other methods
  def is_editable? # used as is pending
    !self.order_items.unshipped.empty?
  end

  def pay
    return false unless self.payment_receipt.nil?
    generate_payment_receipt
    self.save!
    self.payment_receipt
  end

  def total_weight
    weight = self.order_items.inject(0){|sum, oi| sum += oi.item.weight * oi.quantity}
  end

  def shipping_costs
    calculate_shipping_costs(self.total_weight, base=2.00)
  end

  def credit_card_type
    credit_card.type.nil? ? "N/A" : credit_card.type.name
  end

  # Callbacks
  before_destroy :is_destroyable?
  after_destroy :remove_order_items

  def is_destroyable?
    self.order_items.shipped.empty?
  end

  private
  def customer_is_active_in_system
    is_active_in_system(:customer)
  end

  def address_is_active_in_system
    is_active_in_system(:address)
  end

  def generate_payment_receipt
    self.payment_receipt = Base64.encode64("order: #{self.id}; amount_paid: #{self.grand_total}; received: #{self.date}; card: #{self.credit_card_type} ****#{self.credit_card_number[-4..-1]}")
  end

  def credit_card
    CreditCard.new(self.credit_card_number, self.expiration_year, self.expiration_month)
  end

  def credit_card_number_is_valid
    return false if self.expiration_year.nil? || self.expiration_month.nil?
    if self.credit_card_number.nil? || credit_card.type.nil?
      errors.add(:credit_card_number, "is not valid")
      return false
    end
    true
  end

  def expiration_date_is_valid
    return false if self.credit_card_number.nil? 
    if self.expiration_year.nil? || self.expiration_month.nil? || credit_card.expired?
      errors.add(:expiration_year, "is expired")
      return false
    end
    true
  end

  def remove_order_items
    self.order_items.each{ |oi| oi.destroy }
  end

end
