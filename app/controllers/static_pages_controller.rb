require 'will_paginate/array'

class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@post  = current_user.posts.build
      @posts=current_user.postOfFollowing(current_user.followed_users)
      @feed_items=  @posts.paginate(page: params[:page])
    end
  end

  def contact
  end

  def help
  end

  def about
  end
end
