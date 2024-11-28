Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root to: "recipes#index"

  resources :fridge_scans, only: %i[show new create update] do
    resources :recipes, only: %i[create index] do
      member do
        patch :add_favorite
        patch :remove_favorite
      end
    end
  end
  resources :recipes, only: %i[show update] do
  end
end
