require "test_helper"

class TwitterServiceTest < ActiveSupport::TestCase
  def create_user_torie
    User.create( { name: "Torie Joy-Warren",
                   nickname: "torie_jw",
                   third_party_id: ENV["torie_uid"],
                   access_token: ENV["torie_access_token"],
                   access_token_secret: ENV["torie_access_token_secret"] } )
  end

  test "returns tweets from twitter feed" do
    skip
    create_user_torie
    service = TwitterService.new(User.find_by(nickname: "torie_jw"))

    VCR.use_cassette("twitter-user-torie") do
      service.tweets_from_feed
    end
  end
end
