require 'will_paginate/array'

class TweetsController < ApplicationController
  def index
    if !current_user
      redirect_to root_path
    else
      @tweets = service.tweets_from_feed.paginate(page: params[:page], per_page: 10)
    end
  end

  def new
  end

  def create
    service.compose_tweet(params["tweet_content"])
    redirect_to feed_path
  end

  def favorite
    service.favorite_tweet(params["tweet_id"])
    redirect_to feed_path
  end
end
