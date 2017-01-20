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

	def destroy
		session[:user] = nil
		redirect_to root_path
	end

end
