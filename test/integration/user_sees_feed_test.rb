require "test_helper"

class UserSeesFeedTest < ActionDispatch::IntegrationTest
  test "user sees recent tweets from people they follow" do
    skip
    login_user
    assert_equal feed_path, current_path
    # I expect to see recent tweets from people I follow.
    # ??!?!?!?!?!
  end
end
