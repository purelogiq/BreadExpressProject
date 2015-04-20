# require needed files
require './test/sets/items'
require './test/sets/item_prices'
require './test/sets/orders'
require './test/sets/order_items'
require './test/sets/customers'
require './test/sets/addresses'
require './test/sets/users'
require './test/sets/credit_cards'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Items
  include Contexts::ItemPrices
  include Contexts::Orders
  include Contexts::OrderItems
  include Contexts::Customers
  include Contexts::Addresses
  include Contexts::Users
  include Contexts::CreditCards
end