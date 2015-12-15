class TweetsController < ApplicationController
  def index
    redirect_to root_path if !current_user
    service = TwitterService.new(current_user)
  end
end
