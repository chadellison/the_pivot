  Rails.application.routes.draw do

  root 'photos#index'
  get '/cart', to: "carts#show"
  post '/cart', to: "carts#create"
  delete '/cart', to: "carts#destroy"
  resources :photos, only: [:index, :show, :create]
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: "users#new", as: :users
  post '/signup', to: 'users#create'
  get '/dashboard/:id', to: "users#show", as: :dashboard
  get '/vendors', to: "vendors#index"
  get '/category/:name', to: "categories#show", as: :category
  resources :orders, only: [:show, :create, :index]
  get '/download', to: "downloads#show", as: :download

  namespace :vendor_admin do
    resources :vendors, only: [:show, :update]
  end

  namespace :platform_admin do
    resources :vendors, only: [:index, :show, :destroy, :edit, :update]
    resources :photos, only: [:index, :destroy, :edit, :update]
    get "/dashboard", to: "dashboard#show"
  end

  get "/:vendor", to: "vendors#show", as: :vendor

end
