Rails.application.routes.draw do
  resources :films, path: 'movies'
  resources :characters
end
