require './test/contexts'
include Contexts

Given /^a valid admin$/ do
  @profh = FactoryGirl.create(:user, username: "profh", role: "admin")
end

Given /^a logged-in admin$/ do
  step "a valid admin"
  visit login_path
  fill_in "Username", with: "profh"
  fill_in "Password", with: "secret"
  click_button("Log In")
end

Given /^a logged-in customer$/ do
  visit login_path
  fill_in "Username", with: "alexe"
  fill_in "Password", with: "secret"
  click_button("Log In")
end

Given /^an initial setup$/ do
  create_employee_users
  create_customer_users
  create_customers
  create_addresses
  create_items
  create_item_prices
  create_orders
end

Given /^no setup yet$/ do
  # assumes initial setup already run as background
  destroy_items
  destroy_item_prices
  destroy_orders
  destroy_addresses
  destroy_customers
  destroy_employee_users
  destroy_customer_users
end
