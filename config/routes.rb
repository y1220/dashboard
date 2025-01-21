Rails.application.routes.draw do
  get 'questionnaire/index', to: 'questionnaire#index'
  get 'questionnaire/show/:id', to: 'questionnaire#show'
  get 'patient/categorized_list/:id', to: 'patient#categorized_list'
  get 'patient/export', to: 'patient#export'
  root 'dashboard#index'

  namespace :api do
    resources :communications, only: [:index]
    resources :personality_types, only: [:index] do
      collection do
        get 'persona_statistics'
        get 'patient_satisfaction'
      end
    end
    resources :retention_rates, only: [:index]
    resources :response_times, only: [:index]
  end
end
