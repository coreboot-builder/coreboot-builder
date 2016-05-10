Rails.application.routes.draw do
	root to: "frontpage#index"
	post "start-build" => 'frontpage#start_build'

  get "/status/:uuid" => "build_status#show"

  namespace :api do
    namespace :v1 do
      get "/call/:uuid" => "jenkins#call"
    end
  end
end
