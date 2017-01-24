class MatchesController < ApplicationController

	def create
		@category = params[:match][:category].capitalize
		response = Unirest.get "https://od-api.oxforddictionaries.com:443/api/v1/wordlist/en/domains%3D#{@category}?limit=3&offset=#{rand(1..50)}", headers: { "Accept" => "application/json", "app_id" => "d2092c51", "app_key" => "35fe0d68b185289c6bcd1f7050773e2a"}
		@word = response.body["results"].sample["word"]
		@match = Match.new(category: @category, word: @word)
		if @match.save
			redirect_to @match
		else
			redirect_to "/game/new"
		end
	end

	def show
		@match = Match.find(params[:id])
		@word = @match.word
		@puzzle = make_slots(@word).join(" ")
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
end
