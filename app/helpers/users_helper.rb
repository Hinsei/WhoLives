module UsersHelper

	def current_user
		if session[:user_id]
			@current_user ||= User.find(session[:user_id])
		end
	end

	def login?
		!current_user.nil?
	end


	def authorized?
		if current_user.role == 0
			false
		else
			true
		end
	end

end
