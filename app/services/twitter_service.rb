class TwitterService
  attr_reader :client, :uid

  def initialize(user)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_api_key"]
      config.consumer_secret     = ENV["twitter_api_secret"]
      config.access_token        = user.access_token
      config.access_token_secret = user.access_token_secret
    end

    @uid = user.third_party_id
  end

  def tweets

  end

  def tweets_from_feed
    @client.home_timeline
  end

  def feed_tweet_content
    tweets_from_feed.map { |tweet| tweet.text }
  end

  def user_tweets
    @client.user_timeline(uid)
  end
end
