Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :stations, only: [:index]
  resources :conditions, only: %i[index show]
  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#dashboard'

  resources :trips, only: [:index, :show]
  resources :accessories, path: 'bike-shop', only: [:show, :index]
  get '/:name', to: 'stations#show'
  post '/cart', to: 'cart#create'
  get '/cart', to: 'cart#index'
end
