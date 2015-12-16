class TweetsController < ApplicationController
  def index
    if !current_user
      redirect_to root_path
    else
      @service = TwitterService.new(current_user)
    end
  end
end
