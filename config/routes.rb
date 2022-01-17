Rails.application.routes.draw do
  resources :sections
  root to: 'auctions#index', as: :root

  resources :auctions
  devise_for :users


end
