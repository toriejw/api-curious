class TwitterService
  def initialize(user)
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_api_key"]
      config.consumer_secret     = ENV["twitter_api_secret"]
      config.access_token        = user.access_token
      config.access_token_secret = user.access_token_secret
    end
  end
end
