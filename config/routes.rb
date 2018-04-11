Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :stations, only: [:index]
  resources :conditions, only: %i[index show]
  resources :users, only: [:new, :create]

  namespace :admin do
    resources :stations, except: %i[index show]
    resources :trips, except: %i[index show]
    get '/dashboard', to: 'dashboard#index'
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/cart', to: 'cart#index'
  post '/cart', to: 'cart#create'
  delete '/cart', to: 'cart#destroy'


  get '/dashboard', to: 'users#dashboard'

  resources :trips, only: [:index, :show]
  resources :accessories, path: 'bike-shop', only: [:show, :index]
  get '/:name', to: 'stations#show'
end
