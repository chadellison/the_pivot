Rails.application.routes.draw do
  resources :photos, only: [:index, :show, :create]
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/signup', to: "users#new"

  # resources :users, only: [:create, :update]
  # resources :charges, only: [:new, :create]

  # resources :trip_packages, only: [:create, :destroy, :update]
  # resources :orders, only: [:show, :create]
  # resources :destinations, only: [:create]
  #
  # delete '/logout', to: 'sessions#destroy'
  # get '/dashboard', to: "users#show"
  # get '/trip', to: "trip_packages#show"
  # get '/orders' , to: "orders#index"
  #
  #
  # namespace :admin do
  get '/dashboard/:id', to: "users#show", as: :dashboard
  #   resources :users, only: [:update, :delete]
  #   get '/orders' , to: "orders#index"
  # end
  #
  # get '/:planet', to: "destinations#show", as: :destination
  get "/:vendor", to: "vendors#show", as: :vendor
end
