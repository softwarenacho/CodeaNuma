Rails.application.routes.draw do

  root  'static_pages#home'

  match '/api_create',  to: 'proposals#api_create',         via: 'post'
  match '/api_counter',  to: 'proposals#api_counter',         via: 'post'
  match '/api_decrement',  to: 'proposals#api_decrement',         via: 'post'

  resources :proposals

  get '/auth/:provider/callback', to: 'twitter_users#twitter_create'

  match '/twitter_search', to: 'twitter_users#search_users', via: 'get'


  match '/add_proposal', to: 'proposals#add_proposal', via: 'post', as: 'add_proposal'

  resources :users

  resources :sessions, only: [:new, :create, :destroy]

  match '/signout', to: 'sessions#destroy',     via: 'delete'

end
