class FrontendController < ApplicationController
	def index
    @build = Build.new
	end

	def start_build
		puts params
		render "index"
	end
end
