Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :expenses, only: [:create]
      resources :groups do
        member do
          post 'add_user'
          post 'enable_simplify_debt'
          post 'disable_simplify_debt'
          get 'fetch_bills_of_group'
          get 'fetch_debts_of_group'
        end
      end
    end
  end
end
