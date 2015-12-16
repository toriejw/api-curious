require "test_helper"

class TwitterServiceTest < ActiveSupport::TestCase
  def create_user_torie
    User.create( { name: "Torie Joy-Warren",
                   nickname: "torie_jw",
                   third_party_id: ENV["torie_uid"],
                   access_token: ENV["torie_access_token"],
                   access_token_secret: ENV["torie_access_token_secret"] } )
  end

  test "returns content from home feed" do
    VCR.use_cassette("twitter_service#feed_tweet_content") do
      create_user_torie
      service = TwitterService.new(User.find_by(nickname: "torie_jw"))
      tweets = service.feed_tweet_content

      assert_equal "Starting XI #CanWNT #Natal2015 https://t.co/ACVRkrVl9l", tweets.first.text
      assert_equal "Canada Soccer", tweets.first.author
    end
  end
end
