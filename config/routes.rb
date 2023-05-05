Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #resources :subscriptions
  #resources :rates
  #resources :billings
  resources :users
  #post 'subscriptions/:id/bill_calculation', to: 'subscriptions#bill_calculation', as: 'subscription_bill_calculation'
  get 'locations/statement', to: 'locations#statement', as: 'location_statement' 
  get 'subscriptions/receipt', to: 'subscriptions#receipt', as: 'subscription_receipt'
  post 'locations/:id/owner_action', to: 'locations#owner_action', as: 'location_owner_action'
  post 'rates/:id/operator_action', to: 'rates#operator_action', as: 'rate_operator_action'
  resources :locations
  resources :subscriptions
  resources :rates
end
