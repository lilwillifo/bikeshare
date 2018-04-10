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

  get '/:name', to: 'stations#show'
end
