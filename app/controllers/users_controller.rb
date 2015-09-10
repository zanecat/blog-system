class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy
	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		@posts = @user.posts.paginate(page: params[:page])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Blog system!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end 
	end

	def edit 
	end

	def index
		@users = User.paginate(page: params[:page])
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_url
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password,:password_confirmation)
	end

	

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end
end
