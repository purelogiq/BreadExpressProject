# require needed files
require 'helpers/validations'
require 'helpers/cart'
require 'helpers/shipping'
require 'helpers/baking'

# create BreadExpressHelpers
module BreadExpressHelpers
  include BreadExpressHelpers::Validations
  include BreadExpressHelpers::Shipping
  include BreadExpressHelpers::Cart
  include BreadExpressHelpers::Baking
end