class ShoppingController < ApplicationController
  include BreadExpressHelpers::Cart

  def update_cart
    if logged_in? && (current_user.role?(:admin) || current_user.role?(:customer))
      update_item_in_cart(params[:item_id].to_i, params[:change_in_quantity].to_i)
      @cart_order_items = get_list_of_items_in_cart
      @cart_total = calculate_cart_items_cost
    else
      @cart_order_items = []
      @cart_total = 0
    end

  end

  def remove_from_cart
    if logged_in? && (current_user.role?(:admin) || current_user.role?(:customer))
      remove_item_from_cart(params[:item_id].to_i)
      @cart_order_items = get_list_of_items_in_cart
      @cart_total = calculate_cart_items_cost
    else
      @cart_order_items = []
      @cart_total = 0
    end
    render 'update_cart'
  end
end
