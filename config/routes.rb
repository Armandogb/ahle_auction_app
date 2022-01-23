Rails.application.routes.draw do
  resources :items
  resources :sections
  root to: 'auctions#index', as: :root

  resources :auctions
  devise_for :users
  resources :users


end
