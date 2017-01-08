Rails.application.routes.draw do
	root to: 'builds#start'
	post 'start-build' => 'frontend#start_build'
  get '/status/:uuid' => "build_status#show"
  get 'credits' => 'frontend#credits'

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

  resources :builds, only: [:show, :new, :create] do
    member do
      get :choose_device
      get :choose_rom
      get :choose_options
      get :choose_gpg

      patch :update_device
      patch :update_rom_file
      patch :update_options
      patch :update_gpg
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
