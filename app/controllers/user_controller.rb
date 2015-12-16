class UserController < ApplicationController
  def show
    @service = TwitterService.new(current_user)
  end
end
