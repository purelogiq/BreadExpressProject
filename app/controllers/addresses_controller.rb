class AddressesController < ApplicationController
  before_action :check_login
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  authorize_resource
  
  def index
    @no_addresses = Address.all.empty?
    @show_active = !(params[:show_inactive] == 'true')
    if current_user.role? :customer
      if @show_active
        @addresses = current_user.customer.addresses.active.by_recipient.paginate(:page => params[:page]).per_page(10)
      else
        @addresses = current_user.customer.addresses.inactive.by_recipient.paginate(:page => params[:page]).per_page(10)
      end
    else
      if @show_active
        @addresses = Address.active.by_customer.by_recipient.paginate(:page => params[:page]).per_page(10)
      else
        @addresses = Address.inactive.by_customer.by_recipient.paginate(:page => params[:page]).per_page(10)
      end
    end
  end

  def show
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to addresses_path,
                  notice: "The address was added, you can now <a href='/orders/new' style='color: #0596F3'>checkout</a> an order with this address."
    else
      render action: 'new'
    end
  end

  def update
    if @address.update(address_params)
      redirect_to @address, notice: "The address was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_url, notice: "The address was successfully deleted or made inactive."
  end

  private
  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    set_customer_id
    params.require(:address).permit(:recipient, :street_1, :street_2, :city, :state, :zip, :active, :is_billing, :customer_id)
  end

  def set_customer_id
    unless current_user.role?(:admin)
      params[:address][:customer_id] = current_user.customer.id
    end
  end

end
