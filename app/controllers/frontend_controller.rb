class FrontendController < ApplicationController
	def index
	end

	def start_build
		puts params
		render "index"
	end
end
