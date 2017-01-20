class User < ApplicationRecord
	# user verification
	has_secure_password

	# validations
	validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: "Please Input A Valid Email Peasant"}
	validates :username, presence: true, uniqueness: true, length: { minimum: 5, message: "Your name is too short peasant"}
	validates :password, length: {minimum: 5}, presence: true, unless: "password.nil?"
	validates :password_confirmation, length: {minimum: 5}, presence: true, unless: "password.nil?"

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
