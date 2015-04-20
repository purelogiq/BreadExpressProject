class Address < ActiveRecord::Base
  # get module to help with some functionality
  include BreadExpressHelpers::Validations
  # get an array of the states in U.S.
  STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]

  # Relationships
  has_many :orders
  belongs_to :customer

  # Scopes
  scope :by_recipient,  -> { order(:recipient) }
  scope :by_customer,   -> { joins(:customer).order('customers.last_name').order('customers.first_name') }
  scope :shipping,      -> { where(is_billing: false) }
  scope :billing,       -> { where(is_billing: true) }
  scope :active,        -> { where(active: true) }
  scope :inactive,      -> { where(active: false) }
  
  # Validations
  validates_presence_of :street_1, :recipient
  validates_format_of :zip, with: /\A\d{5}\z/, message: "should be five digits long"
  validates_inclusion_of :state, in: STATES_LIST.map{|key, value| value}, message: "is not an option"
  # validates_inclusion_of :state, in: STATES_LIST.to_h.values, message: "is not an option"
  validate :customer_is_active_in_system
  validate :address_is_not_a_duplicate, on: :create

  def already_exists?
    Address.where(customer_id: self.customer_id, recipient: self.recipient, zip: self.zip).size == 1
  end

  # Callbacks
  before_destroy :is_destroyable?
  after_rollback :make_inactive_if_trying_to_destroy

  # Other methods
  private
  def is_destroyable?
    @destroyable = self.orders.empty?
  end
  
  def make_inactive_if_trying_to_destroy
    if !@destroyable.nil? && @destroyable == false
      self.update_attribute(:active, false)
    end
    @destroyable = nil
  end

  def customer_is_active_in_system
    is_active_in_system(:customer)
  end

  def address_is_not_a_duplicate
    return true if self.customer_id.nil? || self.recipient.nil? || self.zip.nil?
    if self.already_exists?
      errors.add(:recipient, "already exists for this recipient at this zip code")
    end
  end

end
