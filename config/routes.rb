Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/search', to: 'pages#search'
  get '/filtre', to: 'doctors#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :doctors, only: [:index, :show] do
    resources :favorites, only: [:create]
    resources :recommendations, only: [:new, :create]
  end
  resources :favorites, only: [:destroy]

  resources :profiles, only: [:show, :index] do
    resources :friendships, only: [:create]
  end
  resources :friendships, only: [:destroy]

  get 'dashboard', to: 'pages#dashboard', as: :dashboard
end
