require "test_helper"

class UserCanPostTweetsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = ApiCurious::Application
    stub_omniauth
  end

  test "user can access form to update tweet" do
    login_user

    assert page.has_link? "Tweet"

    click_link "Tweet"

    assert_equal compose_tweet_path, current_path

    assert page.has_content? "Compose new Tweet"
    assert page.has_button? "Tweet"
  end
end
