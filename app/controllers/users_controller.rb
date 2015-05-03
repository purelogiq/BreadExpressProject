class UsersController < ApplicationController
  before_action :check_login, except: [:new, :create]
  before_action :set_user, only: [:edit, :update, :destroy]
  #authorize_resource

  def index
    @show_active = !(params[:show_inactive] == 'true')
    if @show_active
      @users = User.active.employees.by_role.alphabetical.paginate(page: params[:page]).per_page(10)
    else
      @users = User.inactive.employees.by_role.alphabetical.paginate(page: params[:page]).per_page(10)
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "#{@user.username} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    # Prevent a case where that can cause no admins to be in the system.
    if current_user.username == @user.username && current_user.role?(:admin) && params[:user][:role] != "admin"
      @user.errors.add(:role, "Cannot set your own admin account to a lower role, ask another admin to change it.")
    end
    if @user.errors.empty? && @user.update(user_params)
      redirect_to users_path, notice: "#{@user.username} was revised in the system."
    else
      render action: 'edit'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :role, :password, :password_confirmation, :active)
  end
end