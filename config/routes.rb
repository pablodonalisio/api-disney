Rails.application.routes.draw do
  resources :genres, only: %i[create update destroy]
  resources :films, path: 'movies'
  resources :characters
  resources :users
  get 'login', to: 'authentication#login'
end
