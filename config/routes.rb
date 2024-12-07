Rails.application.routes.draw do
  root 'dashboard#index'

  namespace :api do
    resources :communications, only: [:index]
    resources :personality_types, only: [:index] do
      collection do
        get 'persona_statistics'
      end
    end
    resources :retention_rates, only: [:index]
    resources :response_times, only: [:index]
  end
end
