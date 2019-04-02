Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#index"
  resources :items, only: [:index]
  # get "/merchants", to: merchants
  resources :merchants, only: [:index]
  get '/cart', to: "cart#index", as: :cart
  get '/login', to: "sessions#new", as: :login
  resources :users, only: [:new]

end
