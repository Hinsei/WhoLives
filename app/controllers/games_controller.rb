class GamesController < ApplicationController

	def new
		 unless params[:category].nil?
		 	response = Unirest.get "https://od-api.oxforddictionaries.com:443/api/v1/wordlist/en/domains%3D#{params[:category][:choice]}", headers: { "Accept" => "application/json", "app_id" => "d2092c51", "app_key" => "35fe0d68b185289c6bcd1f7050773e2a"}
			@word = response.body["results"].sample["word"]
			@category = params[:category][:choice]
		 end
	end

	def create
		redirect_to new_game_path
	end
end
