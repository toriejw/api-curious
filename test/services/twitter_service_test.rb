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
    VCR.use_cassette("twitter_service#tweets_from_feed") do
      user = create_user_torie
      service = TwitterService.new(user)

      tweets = service.tweets_from_feed

      assert_equal "F - Tancredi, 33, #14.  #CanWNT 108th appearance. Plays for @chicagoredstars, from Ancaster, ON @cityofHamilton (3/11)", tweets.first.text
      assert_equal "Canada Soccer", tweets.first.author
    end
  end

  test "returns user's tweets information" do
    VCR.use_cassette("twitter_service#user_tweets") do
      user = create_user_torie
      service = TwitterService.new(user)
      
      tweets = service.user_tweets

      assert_equal "RT @kerrizor: Elixir School: Lessons in the Fundamentals of Elixir

https://t.co/wAjp92fOBy", tweets.first.text
      assert_equal "Torie Joy-Warren", tweets.first.author
    end
  end
end
