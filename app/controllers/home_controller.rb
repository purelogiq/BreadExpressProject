class HomeController < ApplicationController
  include BreadExpressHelpers::Cart
  include BreadExpressHelpers::Baking
  before_action :check_login, except: [:home, :about, :privacy, :contact]
  authorize_resource :class => false

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

  def baking
    handle_baker_home
  end

  def shipping
    handle_shipper_home
  end

  def ship_item
    unless params[:order_item_id].nil? || params[:order_item_id].blank?
      begin
        oiid = Integer(params[:order_item_id])
        oi = OrderItem.find(oiid)
        oi.shipped_on = Date.today
        oi.save
        redirect_to '/shipping_list', notice: "Order item was checked off."
        return
      rescue
        redirect_to '/shipping_list', alert: "Unable to check off order item as shipped."
        return
      end
    end
    redirect_to '/shipping_list', alert: "Unable to check off order item as shipped."
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
    @baking_list = Item::CATEGORIES.map{|i| {category: i[0], list: create_baking_list_for(i[1])} }
    render 'home/baker_home'
  end

  def handle_shipper_home
    @shipping_list = Order.not_shipped.chronological.to_a
    render 'home/shipper_home'
  end

  def prepare_shop_page
    create_cart
    @items = Item.active.alphabetical.to_a
    @cart_order_items = get_list_of_items_in_cart
    @cart_total = calculate_cart_items_cost
  end
end