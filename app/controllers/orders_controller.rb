class OrdersController < ApplicationController
  include BreadExpressHelpers::Cart
  include BreadExpressHelpers::Shipping
  before_action :check_login
  before_action :set_order, only: [:show, :destroy]
  authorize_resource
  
  def index
    @no_orders = Order.all.empty?
    @show_all = !(params[:show_pending] == 'true')
    if logged_in? && current_user.role?(:customer)
      if @show_all
        @orders = current_user.customer.orders.chronological.paginate(:page => params[:page]).per_page(10)
      else
        @orders = current_user.customer.orders.not_shipped.chronological.paginate(:page => params[:page]).per_page(10)
      end
    else
      if @show_all
        @orders = Order.chronological.paginate(:page => params[:page]).per_page(10)
      else
        @orders = Order.not_shipped.chronological.paginate(:page => params[:page]).per_page(10)
      end
    end
  end

  def show
    @order_items = @order.order_items.to_a
    if current_user.role?(:customer)
      @previous_orders = current_user.customer.orders.chronological.to_a
    else
      @previous_orders = @order.customer.orders.chronological.to_a
    end
  end

  def new
    if get_list_of_items_in_cart.empty?
      redirect_to '/shop', alert: "You cannot checkout an empty cart"
    end
    if (Address.active.empty? && is_admin?) || (!is_admin? && current_user.customer.addresses.active.empty?)
      redirect_to '/addresses/new', alert: "Please create an address to send the order to."
    end
    @order = Order.new
    @order_items = get_list_of_items_in_cart
    @cart_cost = calculate_cart_items_cost
    @shipping_cost = calculate_cart_shipping
    @grand_total = @cart_cost + @shipping_cost
  end

  def create
    @order = Order.new(order_params)
    convert_cc_to_nums
    reset_fields
    if @order.errors.empty? && @order.save
      save_each_item_in_cart(@order)
      clear_cart
      redirect_to @order, notice: "Thank you for ordering from Bread Express."
    else
      render action: 'new'
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, notice: "This order was cancelled."
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end

  def reset_fields
    @order.customer_id = current_user.customer.id unless is_admin?
    @order.date = Date.today
    @order_items = get_list_of_items_in_cart
    @cart_cost = calculate_cart_items_cost
    @shipping_cost = calculate_cart_shipping
    @grand_total = @cart_cost + @shipping_cost
    @order.grand_total = @grand_total
  end

  def convert_cc_to_nums
    begin
      @order.credit_card_number = Integer(params[:order][:credit_card_number])
    rescue
      @order.errors.add(:credit_card_number, "must be a number (no spaces)")
    end
    begin
      @order.expiration_year = Integer(params[:order][:expiration_year])
    rescue
      @order.errors.add(:expiration_year, "must be a number")
    end
    begin
      @order.expiration_month = Integer(params[:order][:expiration_month])
    rescue
      @order.errors.add(:expiration_month, "must be a number")
    end
  end

  def order_params
    params.require(:order).permit(:address_id, :customer_id,
                                  :credit_card_number, :expiration_year, :expiration_month)
  end
end