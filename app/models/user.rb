class User < ActiveRecord::Base
  def self.from_omniauth(user_info)
    raw_info = user_info["extra"]["raw_info"]
    self.where(third_party_id: user_info["uid"]).first_or_create do |user|
      user.name                = raw_info["name"]
      user.nickname            = raw_info["screen_name"]
      user.access_token        = user_info["credentials"]["token"]
      user.access_token_secret = user_info["credentials"]["secret"]
    end
  end
end
