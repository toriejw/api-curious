class TweetsController < ApplicationController
  def index
    if !current_user
      redirect_to root_path
    end
  end

  def new
  end

  def create
    service.compose_tweet(params["tweet_content"])
    redirect_to feed_path
  end
end
