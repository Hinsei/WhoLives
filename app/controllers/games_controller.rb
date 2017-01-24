class GamesController < ApplicationController

	def new
			@match = Match.new
	end

	def create
		redirect_to new_game_path
	end
end
