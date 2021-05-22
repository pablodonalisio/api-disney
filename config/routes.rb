Rails.application.routes.draw do
  resources :genres
  resources :films, path: 'movies'
  resources :characters
  resources :users
  post 'login', to: 'authentication#login'
end
