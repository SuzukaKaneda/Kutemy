Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show edit update] do
    get "point" => "users#total_point"
    post "add_point" => "users#add_point"
    post "subtract_point" => "users#subtract_point"

    resources :rewards, only: %i[new create index] do
    post "update_completed" => "rewards#update_completed"
    end
  end

  get "others/getting_ready" => "others#getting_ready"
  get "others/point_explanation" => "others#point_explanation"

  get "recipes/look" => "recipes#look"
  resources :recipes, only: %i[index new create show edit update destroy] do
    collection do
      get :favorites
    end
  end
  resources :favorites, only: %i[create destroy]

  root "others#top"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
end
