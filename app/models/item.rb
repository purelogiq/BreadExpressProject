class Item < ActiveRecord::Base

  # List of allowable categories
  CATEGORIES = [['Bread','bread'],['Muffins','muffins'],['Pastries','pastries']]
  
  # Relationships
  has_many :order_items
  has_many :item_prices
  has_many :orders, through: :order_items

  # Scopes
  scope :alphabetical, -> { order(:name) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  scope :for_category, ->(category) { where(category: category) }

  accepts_nested_attributes_for :item_prices
  
  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates_numericality_of :units_per_item, only_integer: true, greater_than: 0
  validates_numericality_of :weight, greater_than: 0
  validates_inclusion_of :category, in: CATEGORIES.map{|key, value| value}, message: "is not an option"
  # validates_inclusion_of :category, in: CATEGORIES.to_h.values, message: "is not an option"

  # Callbacks
  before_destroy :is_destroyable?
  after_destroy :remove_unshipped_and_unpaid_order_items
  after_rollback :convert_to_inactive

  # Other methods
  def current_price
    curr = self.item_prices.current.first
    if curr.nil?
      return nil
    else
      return curr.price
    end
  end

  def price_on_date(date)
    data = self.item_prices.for_date(date).first
    if data.nil?
      return nil
    else
      return data.price
    end
  end

  private
  def is_destroyable?
    @destroyable = self.order_items.shipped.empty?
  end
  
  def convert_to_inactive
    if !@destroyable.nil? && @destroyable == false
      remove_unshipped_and_unpaid_order_items
      make_inactive
    end
    @destroyable = nil
  end

  def remove_unshipped_and_unpaid_order_items
    self.order_items.unshipped.each{|oi| oi.destroy if oi.order.payment_receipt.nil?}
  end

  def make_inactive
    self.update_attribute(:active, false)
  end

end
