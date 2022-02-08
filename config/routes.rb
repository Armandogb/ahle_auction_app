Rails.application.routes.draw do

  root to: 'auctions#index', as: :root

  get '/a/create_a_bid/:item_id/:user_id/:bid', to: 'bids#ajax_create_bid', as: :ajax_create_bid

  resources :auctions
  devise_for :users
  resources :users

  get '/admin', to: 'auctions#admin_index', as: :admin_index
  get '/my_items', to: 'auctions#my_items_index', as: :my_items_index

  get '/a/generate/winners_report/:section_id', to: 'reports#generate_winners_report', as: :generate_winners_report

  resources :bids
  resources :items
  resources :sections

end
