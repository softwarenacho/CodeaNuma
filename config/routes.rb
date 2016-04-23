Rails.application.routes.draw do
  root "proposals#index"

  resources :proposals
end
