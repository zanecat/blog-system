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

	def search
		@users = User.search(params[:search]).paginate(:per_page => 5, :page => params[:page])
	end

	def index
		@users = User.paginate(page: params[:page])
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_url
	end

	def following
		@title = "Subscribing"
		@user = User.find(params[:id])
		@users = @user.followed_users.paginate(page: params[:page])
		render 'show_follow'
	end

	def followers
		@title = "Subscribers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		render 'show_follow'
	end

	def new_message
		@message=Message.new(unsubscriber_id: current_user.id, unsubscribed_id: params[:unsid], processed: false)
		if @message.save
			flash[:success]="Request has been sent!"
			redirect_to User.find(params[:unsid])
		else
			flash[:fail]="Error, don't request again!"
			redirect_to User.find(params[:unsid])
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password,:password_confirmation, :enterprise)
	end

	

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end
end
