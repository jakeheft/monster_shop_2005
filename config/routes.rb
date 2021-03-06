Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  def put(*) end
  root "welcome#index"

  resources :merchants

  resources :items, except: %i[new create]

  resources :merchants do
    resources :items
  end

  resources :items, only: %i[new create] do
    resources :reviews, only: %i[new create]
  end

  resources :items, only: %i[new create] do
    resources :reviews, only: %i[new create]
  end

  resources :reviews, only: %i[edit update destroy]

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id", to: "cart#modify_quantity"

  resources :orders, only: %i[new create]

  namespace :merchant do
    resources :orders, only: %i[show]
    resources :items
    resources :discounts, except: [:show]
    get "/", to: "dashboard#show"
    patch "/itemorders/:itemorder_id", to: "item_orders#update"
    post "/items/deactivate", to: "items#deactivate"
    post "/items/activate", to: "items#activate"
  end

  namespace :admin do
    resources :merchants, only: %i[index]
    resources :users, only: %i[index show]
    patch '/merchants/disable', to: "merchants#disable"
    patch '/merchants/enable', to: "merchants#enable"
    get '/', to: "dashboard#index"
    get '/users/:id', to: "users#show"
    patch '/:order_id', to: "profile_orders#update"
    get '/merchants/:merchant_id', to: 'merchants#show'
  end

  resources :users, only: %i[create]

  get "/register", to: "users#new"

  namespace :profile do
    get "/", to: "users_dashboard#show"
    get "/edit", to: "users_dashboard#edit"
    patch "/", to: "users_dashboard#update"
    resources :orders, only: %i[index show]
    patch "/orders/:id", to: "orders#cancel"
  end

  get "/password/edit", to: "passwords#edit"
  patch "/password", to: "passwords#update"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: 'sessions#destroy'

end
