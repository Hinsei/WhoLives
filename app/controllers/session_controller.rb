class SessionController < ApplicationController
	def new
	end

	def create
		user = User.authenticate(params[:session][:email], params[:session][:password])
		if user && User.find_by_email(params[:session][:email])
			session[:user_id] = user.id
			redirect_to user_path(user)
		else
			flash[:error] = "Login Failed"
			render "new"
		end
	end

	def create_from_omniauth
		omniauth_hash = request.env["omniauth.auth"]
		authentication = Authentication.find_by_provider_and_uid(omniauth_hash["provider"], omniauth_hash["uid"]) || Authentication.create_with_omniauth(omniauth_hash)

		if authentication.user
			user = authentication.user
			authentication.update_token(omniauth_hash)
		else
			user = User.create_with_auth_and_hash(authentication, omniauth_hash)
		end
		session[:user_id] = user.id
		redirect_to user_path(user)
	end

	def destroy
		session[:user] = nil
		redirect_to root_path
	end

end
