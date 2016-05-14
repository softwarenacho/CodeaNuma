Rails.application.routes.draw do

  root  'static_pages#home'
  resources :proposals

  match '/twitter_search', to: 'twitter_users#search_users', via: 'get', as: 'twitter_users_search'


  match '/add_proposal', to: 'proposals#add_proposal', via: 'post', as: 'add_proposal'



end
