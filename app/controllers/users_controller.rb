class UsersController < ApplicationController

	before_action :find_user, only: [ :show, :edit, :update, :destroy ]


	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "You have successfuly joined the fun."
			redirect_to users_path(@user)
		else
			flash[:error] = "You have not successfuly joined the fun. Try again."
			render "new"
		end
	end

	def show
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:notice] = "Update succesful"
			redirect_to @user
		else
			flash[:error] = "Failed to update records"
			render "edit"
		end
	end

	def destroy
		@user.destroy
		redirect_to users_path
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end

	def find_user
		@user = User.find(params[:id])
	end

end
