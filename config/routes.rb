Rails.application.routes.draw do
  root to: "frontend#index"
  post "start-build" => 'frontend#start_build'
  get "/status/:uuid" => "build_status#show"

  # API endpoints
  namespace :api do
    namespace :v1 do
      resources :builds, only: [] do
        member do
          patch :finish
          patch :fail
        end
      end

      resources :vendors, only: [:index]
      resources :devices, only: [:index]
    end
  end

  resources :build

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
