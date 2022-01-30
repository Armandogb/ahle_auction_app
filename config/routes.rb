Rails.application.routes.draw do
  resources :bids
  resources :items
  resources :sections
  root to: 'auctions#index', as: :root

  get '/a/create_a_bid/:item_id/:user_id/:bid', to: 'bids#ajax_create_bid', as: :ajax_create_bid

  resources :auctions
  devise_for :users
  resources :users

  get '/admin', to: 'auctions#admin_index', as: :admin_index

end
