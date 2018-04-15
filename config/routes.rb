Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :stations, only: [:index]
  resources :conditions, only: %i[index show]
  resources :users, only: [:new, :create]

  namespace :admin do
    resources :stations, except: %i[index show]
    resources :trips, except: %i[index show]
    resources :accessories, path: 'bike-shop', only: [:index, :edit, :update]
    resources :conditions, except: %i[index show]
    resources :orders, only: %i[show]
    get '/dashboard', to: 'dashboard#index'
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/cart', to: 'cart#index'
  post '/cart', to: 'cart#create'
  patch '/cart', to: 'cart#update'
  delete '/cart', to: 'cart#destroy'

  get '/dashboard', to: 'users#dashboard'
  get '/conditions-dashboard', to: 'conditions#dashboard'
  get '/stations-dashboard', to: 'stations#dashboard'
  get '/trips-dashboard', to: 'trips#dashboard'

  resources :trips, only: [:index, :show]
  resources :accessories, path: 'bike-shop', only: [:show, :index]
  resources :orders
  resources :users, only: %i[edit update]
  get '/:name', to: 'stations#show'
end
