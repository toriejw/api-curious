class SessionsController < ApplicationController
  def create
    session[:user_id] = request.env["omniauth.auth"]["extra"]["raw_info"]["id_str"]
    redirect_to feed_path
  end
end
