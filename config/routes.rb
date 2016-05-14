  Rails.application.routes.draw do

  root 'photos#index'
  resources :photos, only: [:index, :show, :create]

  namespace :platform_admin do
    resources :vendors, only: [:index, :show, :destroy]
  end

  namespace :vendor_admin do
    resources :vendors, only: [:show, :update]
  end

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/signup', to: "users#new", as: :users
  post '/signup', to: 'users#create'

  get '/dashboard/:id', to: "users#show", as: :dashboard
  get "/:vendor", to: "vendors#show", as: :vendor

  get '/category/:name', to: "categories#show", as: :category


  # namespace :vendor, path: '/:vendor', as: :vendor do
  #   get '/dashboard', to: 'dashboards#show', as: :dashboard
  # end
  # resources :users, only: [:create, :update]
  # resources :charges, only: [:new, :create]

  # resources :trip_packages, only: [:create, :destroy, :update]
  # resources :orders, only: [:show, :create]
  # resources :destinations, only: [:create]
  #
  # delete '/logout', to: 'sessions#destroy'
  # get '/dashboard', to: "users#show"
  get '/cart', to: "carts#show"
  post '/cart', to: "carts#create"
  # get '/orders' , to: "orders#index"
  #
  #
  # namespace :admin do
  #   resources :users, only: [:update, :delete]
  #   get '/orders' , to: "orders#index"
  # end
  #
end
