Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  root to: 'welcome#index'
  resources :stations, only: [:index]
  resources :conditions, only: %i[index show]
  resources :users, only: [:new]

  get '/login', to: 'sessions#new'

  get '/:name', to: 'stations#show'

end
