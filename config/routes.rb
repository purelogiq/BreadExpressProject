BreadExpress::Application.routes.draw do

  # Routes for main resources
  resources :addresses
  resources :customers
  resources :orders
  resources :users
  resources :sessions

  # Authentication routes
  get 'signup' => 'customers#new', as: :signup
  get 'logout' => 'sessions#destroy', as: :logout
  get 'login' => 'sessions#new', as: :login


  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'index' => 'home#home'
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'shop' => 'home#shop', as: :shop
  get 'manage' => 'home#manage', as: :manage
  get 'search' => 'home#search', as: :search
  get 'cylon' => 'errors#cylon', as: :cylon

  # Ajax calls
  post 'update_cart' => 'shopping#update_cart', as: :update_cart
  post 'remove_from_cart' => 'shopping#remove_from_cart', as: :remove_from_cart

  # Set the root url
  root :to => 'home#home'  
  
  # Named routes
  get 'ldfasa' => 'errors#cylon', as: :items
  #get 'dsaf' => 'errors#cylon', as: :cylon
  #get 'dsfdasf' => 'errors#cylon', as: :cylon
  #get '45fd' => 'errors#cylon', as: :cylon


  
  # Last route in routes.rb that essentially handles routing errors
  get '*a', to: 'errors#routing'
end
