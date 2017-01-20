class Authentication < ApplicationRecord
	belongs_to :user

	def self.create_with_omniauth(omniauth_hash)
		auth = Authentication.new(provider: omniauth_hash["provider"], uid: omniauth_hash["uid"], token: omniauth_hash["credentials"]["token"])
	end

	def update_token(omniauth_hash)
		self.token = omniauth_hash["credentials"]["token"]
		self.save
	end
end
