class ItemPrice < ActiveRecord::Base
  # get module to help with some functionality
  include BreadExpressHelpers::Validations

  # Relationships
  belongs_to :item

  # Scopes
  scope :current,       -> { where(end_date:nil) }
  scope :chronological, -> { order(start_date: :desc ) }
  scope :for_date,      ->(date) { where("start_date <= ? AND (end_date > ? OR end_date IS NULL)", date, date) }
  scope :for_item,      ->(item_id) { where(item_id: item_id) }


  # Validations
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_date :start_date
  validates_date :end_date, on_or_after: :start_date, allow_blank: true
  validate :item_is_active_in_system

  # Callbacks
  before_create :set_end_date_of_old_price
  before_destroy :is_never_destroyable

  # Other methods
  private
  def item_is_active_in_system
    is_active_in_system(:item)
  end

  def set_end_date_of_old_price
    previous = ItemPrice.current.for_item(self.item_id).take
    previous.update_attribute(:end_date, self.start_date) unless previous.nil?
  end

end
