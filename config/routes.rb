Rails.application.routes.draw do
  resources :items
  resources :sections
  root to: 'auctions#index', as: :root

  resources :auctions
  devise_for :users
  resources :users

  get '/admin', to: 'auctions#admin_index', as: :admin_index

end
