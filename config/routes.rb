Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#index"

  resources :items, only: [:index]

  #merchant routes
  resources :merchants, only: [:index]
  get '/dashboard', to: 'merchants#dashboard', as: :dashboard

  #admin routes
  namespace :admin do
    get '/dashboard', to: 'dashboard#show', as: :dashboard
  end

  #user routes
  get '/cart', to: "cart#index", as: :cart
  get '/profile', to: "users#show", as: :profile

  #all users routes
  get '/login', to: "sessions#new", as: :login
  post '/login', to: "sessions#create"

  get '/logout', to: "sessions#destroy", as: :logout
  resources :users, only: [:new]
end
