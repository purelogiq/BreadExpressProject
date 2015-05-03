class SessionsController < ApplicationController
  include BreadExpressHelpers::Cart
  def new
  end

  def create()
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      if user.active?
        session[:user_id] = user.id
        redirect_to root_url
      else
        flash.now.alert = "This user account is deactivated, contact an adminstrator to reactivate it."
        render "new"
      end
    else
      flash.now.alert = "Username or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    destroy_cart
    redirect_to root_url
  end
end