class HomeController < ApplicationController
  include BreadExpressHelpers::Cart

  def home
    if current_user.nil?
      handle_guest_home
    elsif current_user.role? :admin
      handle_admin_home
    elsif current_user.role? :baker
      handle_baker_home
    elsif current_user.role? :shipper
      handle_shipper_home
    elsif current_user.role? :customer
      handle_customer_home
    else  # Should technically be impossible
      handle_guest_home
    end
  end

  def shop
    handle_customer_home
  end

  def manage
    handle_admin_home
  end

  def about
  end

  def privacy
  end

  def contact
  end

  private
  def handle_guest_home
    prepare_shop_page
    locals = {}
    locals[:page_title] = "Bread Express"
    locals[:page_heading] = "Welcome to Bread Express!"
    locals[:page_info] = "We are a local pastry store in Pittsburgh. See our goods below!"
    render 'home/shop', locals: locals
  end

  def handle_customer_home
    prepare_shop_page
    locals = {}
    locals[:page_title] = "Bread Express - #{current_user.customer.first_name}"
    locals[:page_heading] = "Welcome back to Bread Express #{current_user.customer.first_name}!"
    locals[:page_info] = "Check out the new treats we've been cooking up!"
    render 'home/shop', locals: locals
  end

  def handle_admin_home
    locals = {}
    locals[:page_title] = "Bread Express Admin Panel"
    locals[:page_heading] = "Welcome to Bread Express' Administration Panel"
    locals[:page_info] = "Manage all parts of the Bread Express business here, all in one place!"
    render 'home/admin_home', locals: locals
  end

  def handle_baker_home
    locals = {}
    locals[:page_title] = "Bread Express Baking List"
    locals[:page_heading] = "Welcome to Bread Express's Baking List"
    locals[:page_info] = "See what needs to be baked today."
    render 'home/baker_home', locals: locals
  end

  def handle_shipper_home
    locals = {}
    locals[:page_title] = "Bread Express Shipping Panel"
    locals[:page_heading] = "Welcome to Bread Express' Shipping Panel"
    locals[:page_info] = "Manage which the logistics of customer order here."
    render 'home/shipper_home', locals: locals
  end

  def prepare_shop_page
    create_cart
    @items = Item.active.alphabetical.to_a
    @cart_order_items = get_list_of_items_in_cart
    @cart_total = calculate_cart_items_cost
  end
end