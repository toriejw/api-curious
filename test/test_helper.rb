ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"
require "capybara/rails"
require "mocha/mini_test"
require "minitest/pride"
# require "minitest-stub_any_instance"
# require "vcr"


class ActiveSupport::TestCase
  # VCR.configure do |config|
  #   config.cassette_library_dir = "test/vcr_cassettes"
  #   config.hook_into :webmock
  # end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def login_user
    TwitterService.stub_any_instance(:feed_tweet_content, ["test tweet 1", "test tweet2"]) do
      visit root_path
      click_link "Log In"
    end
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        provider: "twitter",
        uid: "1234",
        extra: { raw_info: { screen_name: "candy",
                             name: "Candy Cat",
                             followers_count: 21,
                             friends_count: 23,
                             statuses_count: 56789,
                             profile_image_url: "http://pbs.twimg.com/profile_images/647059117501054976/qPV7xp3t_normal.jpg" } },
        credentials: { token: "candy_treats", secret: "so_many_treats" } })
  end
end
