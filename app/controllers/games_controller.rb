class GamesController < ApplicationController
	before_action :display, only: [:index]

	def index
	end

	def new
			@match = Match.new
	end

	private

	def display
		@matches = Match.not_full
	end

end
