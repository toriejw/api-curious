require "test_helper"

class UserSeesFeedTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = ApiCurious::Application
    stub_omniauth
  end

  test "user sees a favorite button below each tweet" do
    login_user

    assert_equal feed_path, current_path
    assert page.has_css? ".glyphicon-heart"
  end
end
