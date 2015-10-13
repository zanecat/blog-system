class MessagesController < ApplicationController
	before_action :admin_user, only: :index

  def index
  	@messages=Message.all
  end
end
