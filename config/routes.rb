Rails.application.routes.draw do
  resources :employees do
    resources :time_off_requests, only: [ :new, :create, :index, :destroy, :update ]
    resources :employee_time_logs, only: [ :create, :update, :edit, :destroy ] do
      member do
        patch :clock_out
      end
    end
  end

  resources :time_off_requests, only: [ :index ]


  resources :jsas do
    member do
      get :pdf
    end
  end

  get "clock_in", to: "employee_time_logs#clock_in_page"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "jsas#index"
end
