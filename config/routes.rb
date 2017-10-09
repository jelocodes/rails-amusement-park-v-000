Rails.application.routes.draw do
  resources :users
  resources :attractions

  root 'static#main'

  get    '/signin',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'

end
