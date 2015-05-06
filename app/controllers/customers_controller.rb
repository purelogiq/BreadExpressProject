class CustomersController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :check_login, except: [:new, :create]
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  #authorize_resource
  
  def index
    @no_customers = Customer.all.empty?
    @show_active = !(params[:show_inactive] == 'true')
    if @show_active
      @customers = Customer.active.alphabetical.paginate(page: params[:page]).per_page(10)
    else
      @customers = Customer.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
    end
  end

  def show
    @order_history = @customer.orders.chronological
    @addresses = @customer.addresses.by_recipient
  end

  def new
    @customer = Customer.new
    @customer.user = User.new
  end

  def edit
    # reformat phone w/ dashes when displayed for editing (preference; not required)
    @customer.phone = number_to_phone(@customer.phone)
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: "#{@customer.proper_name} was added to the system." if logged_in? && is_admin?
      unless logged_in? # Login in guest after they create an account
        session[:user_id] = @customer.user.id
        redirect_to root_url, notice: "You have successfully signed up!"
      end
    else
      render action: 'new'
    end
  end

  def update
    # just in case customer trying to hack the http request...
    reset_user_params unless is_admin?
    if @customer.update(customer_params)
      redirect_to @customer, notice: "#{@customer.proper_name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  private
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    reset_role_param unless is_admin?
    params.require(:customer).permit(:first_name, :last_name, :email, :phone, :active,
                                     :user_attributes => [:id, :username, :role, :password, :password_confirmation])
  end

  def reset_role_param
    params[:customer][:user_attributes][:role] = "customer"
  end

  def reset_user_params
    params[:customer][:user_attributes][:id] = @customer.user.id
    params[:customer][:user_attributes][:username] = @customer.user.username
  end
end