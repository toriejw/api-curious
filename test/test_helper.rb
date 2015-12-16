ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"
require "capybara/rails"
require "mocha/mini_test"
require "minitest/pride"
# require "vcr"

# VCR.configure do |config|
#   config.cassette_library_dir = "fixtures/vcr_cassettes"
#   config.hook_into :webmock
# end

class ActiveSupport::TestCase
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def login_user
    visit root_path
    click_link "Log In"
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
                             statuses_count: 56789 } },
        credentials: { token: "candy_treats", secret: "so_many_treats" } })
  end
end
