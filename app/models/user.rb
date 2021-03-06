class User < ApplicationRecord
	# user verification
	has_secure_password

	enum role: {user: 0, admin: 1, king: 2}

	# associations
	has_many :authentications, dependent: :destroy
	# validations
	validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: "Please Input A Valid Email Peasant"}
	validates :username, presence: true, uniqueness: true, length: { minimum: 5, message: "Your name is too short peasant"}
	validates :password, length: {minimum: 5}, presence: true, unless: "password.nil?"
	validates :password_confirmation, length: {minimum: 5}, presence: true, unless: "password.nil?"


	def self.create_with_auth_and_hash(authentication, omniauth_hash)
		password = SecureRandom.urlsafe_base64
		user = User.create!(username: omniauth_hash["extra"]["raw_info"]["name"] , email: omniauth_hash["extra"]["raw_info"]["email"], password: password, password_confirmation: password)
		user.authentications << (authentication)
		return user
	end

	def fb_token
			x = self.authentications.where(provider: :facebook).first
			return x.token unless x.nil?
	end

	private

	def self.authenticate(email, password)
		user = User.find_by(email: email)
  	if user && user.authenticate(password)
  		return user
  	else
  		nil
  	end
  end


end
