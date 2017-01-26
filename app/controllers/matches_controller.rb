class MatchesController < ApplicationController

	before_action :find_match, only: [:show, :finished]
	before_action :find_player_1, only: [:finished]

	def create
		@category = params[:match][:category].capitalize
		response = Unirest.get "https://od-api.oxforddictionaries.com:443/api/v1/wordlist/en/domains%3D#{@category}?limit=3&offset=#{rand(1..50)}", headers: { "Accept" => "application/json", "app_id" => "d2092c51", "app_key" => "35fe0d68b185289c6bcd1f7050773e2a"}
		if response == nil
			flash[:notice] = "Type in another category"
		end
		@word = response.body["results"].sample["word"].gsub(/\s+/, "")
		@match = Match.new(category: @category, word: @word, player_1: session[:user_id])
		if @match.save
			redirect_to @match
		else
			redirect_to "/game/new"
		end
	end

	def show
		# decide player
		if User.find(@match.player_1) == User.find(session[:user_id])
			@player_1 = User.find(session[:user_id])
		elsif Match.find_creator(User.find(session[:user_id])) != User.find(session[:user_id]) && @match.player_2 == nil
			@player_2 = User.find(session[:user_id])
		elsif @match.player_1 != nil && @match.player_2 != nil
			redirect_to new_game_path
		end
		# lives of players
		@p1lives = @match.p1lives
		gon.watch.p1lives = @match.p1lives
		# array of correct words
		@word = @match.word.upcase.chars
		gon.word = @match.word.upcase.chars
		gon.puzzle = make_slots(@word)
		# delete btm
		@puzzle = make_slots(@word).join(" ")
		#delete top
		@alphabets = params["Alphabets"] unless params["Alphabets"].nil?
		if @word.index(@alphabets) == nil && @alphabets != nil
			@match.update(p1lives: (@match.p1lives - 1) )
		end
		respond_to do |format|
			format.js
			format.html
		end
	end

	def finished
		if params[:result] == "dead"
			if @player_1 == User.find(session[:user_id])
				@player_1.update(losses: @player_1.losses + 1)
				@match.update(status: 1)
				redirect_to @player_1
			end
		elsif params[:result] == "solved"
			if @player_1 == User.find(session[:user_id])
				@player_1.update(wins: @player_1.losses + 1)
				@match.update(status: 1)
				redirect_to @player_1
			end
		end
	end

	private

	def make_slots(word)
		array = []
		word.length.times do |x|
			x = "_"
			array << x
		end
		return array
	end

	def guess(word, alphabet)
		letter = [alphabet]
		number = word - letter
		number.length
	end

	def find_match
		@match = Match.find(params[:id])
	end

	def find_player_1
		@player_1 = User.find(params[:player1])
	end
end
