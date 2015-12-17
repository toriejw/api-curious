class User < ActiveRecord::Base
  def self.from_omniauth(user_info)
    raw_info = user_info["extra"]["raw_info"]

    user = self.where(third_party_id: user_info["uid"]).first_or_create do |new_user|
      new_user.name                = raw_info["name"]
      new_user.nickname            = raw_info["screen_name"]
      new_user.access_token        = user_info["credentials"]["token"]
      new_user.access_token_secret = user_info["credentials"]["secret"]
      new_user.followers_count     = raw_info["followers_count"]
      new_user.following_count     = raw_info["friends_count"]
      new_user.tweets_count        = raw_info["statuses_count"]
      new_user.profile_image_url   = raw_info["profile_image_url"]
    end

    check_for_updates(user, raw_info)
  end

  def self.check_for_updates(user, raw_info)
    user.update(name:              raw_info["name"],
                nickname:          raw_info["screen_name"],
                followers_count:   raw_info["followers_count"],
                following_count:   raw_info["friends_count"],
                tweets_count:      raw_info["statuses_count"],
                profile_image_url: raw_info["profile_image_url"])

    user
  end
end
