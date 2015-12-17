require 'will_paginate/array'

class UserController < ApplicationController
  def show
    @tweets = TwitterService.new(current_user).user_tweets.paginate(page: params[:page], per_page: 10)
  end
end
