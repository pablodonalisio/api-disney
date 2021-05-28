Rails.application.routes.draw do
  resources :genres
  resources :films
  resources :characters
  resources :users
  post 'login', to: 'authentication#login'
end
