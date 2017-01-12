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
				picture: '',
				github: 'zaolin',
			},
			'Julian Laubstein': {
				twitter: 'sphinxc0re',
				picture: '',
				github: 'sphinxc0re',
			},
			'Marcel Schütz': {
			},
			'Alexander Dorn': {
				github: 'debao84',
			}
		}

		render 'credits'
	end
end
