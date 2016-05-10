Rails.application.routes.draw do
	root to: "frontpage#index"
	post "start-build" => 'frontpage#start_build'
end
