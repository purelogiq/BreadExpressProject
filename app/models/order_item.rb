class OrderItem < ActiveRecord::Base
  # get module to help with some functionality
  include BreadExpressHelpers::Validations

  # Relationships
  belongs_to :order
  belongs_to :item

  # Scopes
  scope :shipped,   -> { where.not(shipped_on: nil) }
  scope :unshipped, -> { where(shipped_on: nil) }

  # Validations
  validates_numericality_of :quantity, only_integer: true, greater_than: 0
  validates_date :shipped_on, allow_blank: true
  validate :item_is_active_in_system

  # Other methods
  def subtotal(date=Date.today)
    return nil if !date.respond_to?(:future?) || date.future?
    self.item.price_on_date(date) * self.quantity
  end

  private
  def item_is_active_in_system
    is_active_in_system(:item)
  end

end
