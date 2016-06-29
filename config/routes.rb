Rails.application.routes.draw do

  match '/api_create',  to: 'proposals#api_create',         via: 'post'
  match '/api_counter',  to: 'proposals#api_counter',         via: 'post'

  root  'static_pages#home'
  resources :proposals

  get '/auth/:provider/callback', to: 'twitter_users#twitter_create'

  match '/twitter_search', to: 'twitter_users#search_users', via: 'get', as: 'twitter_users_search'


  match '/add_proposal', to: 'proposals#add_proposal', via: 'post', as: 'add_proposal'

  resources :users

  resources :sessions, only: [:new, :create, :destroy]
  
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  resources :password_resets, only: [:edit, :update]

end
