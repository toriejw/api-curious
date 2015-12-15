class User < ActiveRecord::Base
  def self.from_omniauth(user_info)
    raw_info = user_info["extra"]["raw_info"]
    self.where(third_party_id: raw_info["id_str"]).first_or_create do |user|
      user.name     = raw_info["name"]
      user.nickname = raw_info["nickname"]
    end
  end
end
