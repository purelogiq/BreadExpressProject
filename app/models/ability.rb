class Ability
  include CanCan::Ability
  
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user

    if user.role? :admin
      can :manage, :all
    elsif user.role? :customer
      can [:home, :shop, :about, :privacy, :contact], :home
      can :index, [Address, Item, Order]
      can [:new], [Address, Customer, Order, User]
      can [:show], Item
      can [:show, :edit, :create, :update, :destroy], Address, :customer => { :id => user.customer.id }
      can [:show, :edit,:create, :destroy], Order, :customer => { :id => user.customer.id }
      can [:show, :edit, :create, :update], Customer, :id => user.customer.id
      can [:show, :edit,:create, :update], User, id: user.id
    elsif user.role? :baker
      can [:home, :shop, :about, :privacy, :contact], :home
      can [:baking], :home
      can [:index, :show], Item
      can [:new, :edit, :create, :update], User, id: user.id
    elsif user.role? :shipper
      can [:home, :shop, :about, :privacy, :contact], :home
      can [:shipping, :ship_item], :home
      can [:index, :show], Item
      can [:new, :edit, :create, :update], User, id: user.id
    else
      can [:home, :shop, :about, :privacy, :contact], :home
      can [:index, :show], Item
      can [:new, :create], [User, Customer]
    end
  end
end