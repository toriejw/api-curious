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
    save_and_open_page
    within(".user-info") do
      assert page.has_content? "Candy Cat"
      assert page.has_content? "@candy"
      assert page.has_content? "Followers"
      assert page.has_content? user.num_of_followers
      assert page.has_content? "Following"
      assert page.has_content? user.num_following
      assert page.has_content? "Tweets"
      assert page.has_content? user.tweet_count
    end
  end

  test "user can see full profile" do
    skip
    #   As a user,
    # When I'm on my feed,
    # And I click on my profile,
    # I expect to see my profile pic, follower count, following count, etc.
  end
end
