Rails.application.routes.draw do
  resources :genres
  resources :films
  resources :characters
  post 'users', to: 'users#create'
  post 'login', to: 'authentication#login'
end
