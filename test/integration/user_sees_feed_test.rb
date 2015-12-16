require "test_helper"

class UserSeesFeedTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = ApiCurious::Application
    stub_omniauth
  end

  test "user sees recent tweets from people they follow" do
    login_user
    assert_equal feed_path, current_path

    assert page.has_content?("test tweet 1")
    assert page.has_content?("test tweet 2")
  end
end
