Rails.application.routes.draw do
  get "home/redirect"
  get    "/login",  to: "sessions#new",     as: :new_session
  post   "/login",  to: "sessions#create",  as: :session
  delete "/logout", to: "sessions#destroy", as: :destroy_session
  resource :session, only: %i[new create destroy]
  resources :passwords, param: :token
  resources :investors
  resources :registrations, only: %i[new create]
  get "/signup", to: "registrations#new", as: :signup
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#redirect"
end
