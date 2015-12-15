require "test_helper"

class UserIsAuthenticatedWithTwitterTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = ApiCurious::Application
    stub_omniauth
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        provider: "twitter",
        uid: "1234",
        extra: { raw_info: { screen_name: "candy",
                             name: "Candy Cat" } } })
  end

  def login_user
    visit root_path
    click_link "Log In"
  end

  test "visitor can create account using twitter" do
    old_user_count = User.count

    visit root_path
    click_link "Log In"

    assert_equal feed_path, current_path
    assert page.has_content?("Candy Cat")
    assert page.has_content?("@candy")

    assert_equal 1, User.count - old_user_count
  end

  test "user can login using twitter" do
    login_user
    click_link "Log out"
    
    old_user_count = User.count

    assert_equal root_path, current_path
    assert page.has_content?("You have successfully logged out.")

    visit feed_path

    assert_equal root_path, current_path
    assert_equal 0, User.count - old_user_count
  end
end
