Rails.application.routes.draw do
  #general routes
  root to: "welcome#index"
  resources :items, only: [:index, :show, :destroy]
  resources :orders, only: [:show, :update]

  #merchant routes
  resources :items, only: [:new, :create, :index, :show, :destroy]

  resources :merchants, only: [:index, :show] do
    resources :items, only: [:show]
  end

  get '/dashboard', to: 'merchants#show', as: :dashboard
  get '/dashboard/orders/:id', to: 'merchants/orders#show', as: :dashboard_order
  get '/dashboard/items', to: 'merchants/items#index', as: :dashboard_items
  get '/dashboard/items/new', to: 'merchants/items#new', as: :new_merchant_item
  get '/dashboard/items/:id/edit', to: 'merchants/items#edit', as: :edit_item
  patch '/dashboard/items/:id/edit', to: 'merchants/items#update'
  get '/enable_item/:id', to: 'merchants/items#enable_item', as: :enable_item
  get '/fulfill_item/:id', to: 'merchants/items#fulfill_item', as: :fulfill_item
  get '/delete_item/:id', to: 'merchants/items#delete_item', as: :delete_item
  get '/disable_item/:id', to: 'merchants/items#disable_item', as: :disable_item

  #admin routes
  namespace :admin do
    get '/dashboard', to: 'users#dashboard', as: :dashboard
    resources :merchants, only: [:show, :update]
    resources :users, only: [:show, :index]
  end

  #cart routes
  get '/cart', to: "cart#index", as: :cart
  get '/emptycart', to: "cart#destroy", as: :empty_cart
  get '/remove_item/:id', to: "cart#remove_item", as: :remove_item
  get '/increment_item/:id', to: "cart#increment_item", as: :increment_item
  get '/decrement_item/:id', to: "cart#decrement_item", as: :decrement_item
  get '/checkout', to: "cart#checkout", as: :checkout

  #user routes
  get '/profile', to: "users#show", as: :profile
  get '/profile/edit', to: "users#edit", as: :edit_profile
  get '/profile/orders', to: "orders#index", as: :profile_orders
  get '/profile/orders/:id', to: "orders#show", as: :profile_order
  resources :cart, only: [:create]

  #all users routes
  get '/login', to: "sessions#new", as: :login
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy", as: :logout
  get '/register', to: "users#new", as: :registration
  resources :users, only: [:new, :create, :edit, :update] do
    resources :items, only: [:create]
  end

end
