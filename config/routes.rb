Rails.application.routes.draw do
	root to: "frontend#index"
	post "start-build" => 'frontend#start_build'
  get "/status/:uuid" => "build_status#show"

	# API endpoints
  namespace :api do
    namespace :v1 do
      get "/call/:uuid" => "jenkins#call"

      resources :vendors, only: [:index]
      resources :devices, only: [:index]
    end
  end
end
