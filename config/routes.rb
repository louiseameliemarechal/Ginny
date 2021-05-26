Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/search', to: 'pages#search'
  get '/filtre', to: 'doctors#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :doctors, only: :index
end
