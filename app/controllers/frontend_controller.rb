class FrontendController < ApplicationController
	def index
	end

	def start_build
		puts params
		render "index"
	end

	def credits
		@members = {
			'Philipp Deppenwiese': {
				twitter: '_zaolin_',
				picture: ''
			},
			'Julian Laubstein': {
				twitter: 'spinxc0re',
				picture: ''
			},
			'Marcel Schütz': {
			},
			'Alexander Dorn': {
			} 
		}
		render 'credits'
	end
end
