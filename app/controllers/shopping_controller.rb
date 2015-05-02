class ShoppingController < ApplicationController
  include BreadExpressHelpers::Cart

  def update_cart
    update_item_in_cart(params[:item_id].to_i, params[:change_in_quantity].to_i)
    @cart_order_items = get_list_of_items_in_cart
    @cart_total = calculate_cart_items_cost
  end

  def remove_from_cart
    remove_item_from_cart(params[:item_id].to_i)
    @cart_order_items = get_list_of_items_in_cart
    @cart_total = calculate_cart_items_cost
    render 'update_cart'
  end
end
