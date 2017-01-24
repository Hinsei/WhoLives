class MatchesController < ApplicationController

	def new
		@category = params[:category]
		@word = params[:word]
	end
end
