require "ostruct"

class TwitterService
  attr_reader :client, :uid

  def initialize(user)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_api_key"]
      config.consumer_secret     = ENV["twitter_api_secret"]
      config.access_token        = user.access_token
      config.access_token_secret = user.access_token_secret
    end
    @uid = user.third_party_id.to_i
  end

  def tweets_from_feed
    client.home_timeline.map { |tweet| extract_tweet_data(tweet) }
  end

  def user_tweets
    client.user_timeline(uid).map { |tweet| extract_tweet_data(tweet) }
  end

  def extract_tweet_data(tweet)
    OpenStruct.new(text: tweet.text,
                   id: tweet.id,
                   author: tweet.user.name,
                   author_user_name: tweet.user.screen_name,
                   author_profile_image_url: tweet.user.profile_image_url,
                   favorited?: tweet.favorited?)
  end

  def compose_tweet(content)
    client.update(content)
  end

  def favorite_tweet(id)
    client.favorite(id.to_i)
  end
end
