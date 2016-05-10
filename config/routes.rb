Rails.application.routes.draw do
  resources :photos, only: [:index, :show, :create]
  get "/:vendor", to: "vendors#show", as: :vendor
  # resources :users, only: [:create, :update]
  # resources :charges, only: [:new, :create]

  # resources :trip_packages, only: [:create, :destroy, :update]
  # resources :orders, only: [:show, :create]
  # resources :destinations, only: [:create]
  #
  # get '/login', to: "sessions#new"
  # post '/login', to: "sessions#create"
  # get '/signup', to: "users#new"
  # delete '/logout', to: 'sessions#destroy'
  # get '/dashboard', to: "users#show"
  # get '/trip', to: "trip_packages#show"
  # get '/orders' , to: "orders#index"
  #
  #
  # namespace :admin do
  #   get '/dashboard', to: "users#show"
  #   resources :users, only: [:update, :delete]
  #   get '/orders' , to: "orders#index"
  # end
  #
  # get '/:planet', to: "destinations#show", as: :destination
end
