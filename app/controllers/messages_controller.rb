class MessagesController < ApplicationController
	before_action :admin_user, only: :destroy

	def index
		@messages=Message.all
		@unprocessed_messages=@messages.find_by_processed(false)
		@processed_message=@messages.find_by_processed(true)
	end

	def new
		@message=Message.new
	end

	def create
		@message=Message.new(message_params)
		if @message.save
			redirect_to @message
		end
	end

	def admin_user
		current_user.admin?
	end

	def message_params
		params.require(:message).permit(:processed, :unsubscriber_id, :unsubscribed_id)
	end
end
