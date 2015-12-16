require "test_helper"

class UserProfileTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = ApiCurious::Application
    stub_omniauth
  end

  test "user sees basic profile information on feed" do
    login_user
    user = User.find_by(nickname: "candy")

    assert_equal feed_path, current_path
    within(".user-info") do
      assert page.has_content? "Candy Cat"
      assert page.has_content? "@candy"
      assert page.has_content? "FOLLOWERS"
      assert page.has_content? user.followers_count
      assert page.has_content? "FOLLOWING"
      assert page.has_content? user.following_count
      assert page.has_content? "TWEETS"
      assert page.has_content? user.tweets_count
    end
  end

  test "user can see full profile" do
    login_user
    user = User.find_by(nickname: "candy")

    TwitterService.stub_any_instance(:user_tweets, ["Candy tweet 1", "Candy tweet 2"]) do
      click_link "Candy Cat"

      assert_equal user_path(User.first), current_path
      save_and_open_page
      within(".user-info") do
        assert page.has_content? "Candy Cat"
        assert page.has_content? "@candy"
        assert page.has_content? "FOLLOWERS"
        assert page.has_content? user.followers_count
        assert page.has_content? "FOLLOWING"
        assert page.has_content? user.following_count
        assert page.has_content? "TWEETS"
        assert page.has_content? user.tweets_count
      end

      assert page.has_content? "Candy tweet 1"
      assert page.has_content? "Candy tweet 2"
    end
  end
end
