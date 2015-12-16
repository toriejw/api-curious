class User < ActiveRecord::Base
  def self.from_omniauth(user_info)
    raw_info = user_info["extra"]["raw_info"]

    user = self.where(third_party_id: user_info["uid"]).first_or_create do |user|
      user.name                = raw_info["name"]
      user.nickname            = raw_info["screen_name"]
      user.access_token        = user_info["credentials"]["token"]
      user.access_token_secret = user_info["credentials"]["secret"]
      user.followers_count     = raw_info["followers_count"]
      user.following_count     = raw_info["friends_count"]
      user.tweets_count        = raw_info["statuses_count"]
      user.profile_image_url   = raw_info["profile_image_url"]
    end

    check_for_updates(user, user_info)
  end

  def self.check_for_updates(user, user_info)
    raw_info = user_info["extra"]["raw_info"]

    user.update(name:              raw_info["name"],
                nickname:          raw_info["screen_name"],
                followers_count:   raw_info["followers_count"],
                following_count:   raw_info["friends_count"],
                tweets_count:      raw_info["statuses_count"],
                profile_image_url: raw_info["profile_image_url"])

    user
  end
end
