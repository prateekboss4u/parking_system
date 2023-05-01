Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #resources :subscriptions
  #resources :rates
  #resources :billings
  resources :users
  post 'locations/:id/owner_action', to: 'locations#owner_action', as: 'location_owner_action'
  post 'locations/:id/operator_action', to: 'locations#operator_action', as: 'location_operator_action'
  resources :locations
end
