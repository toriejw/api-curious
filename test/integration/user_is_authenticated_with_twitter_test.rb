require "test_helper"

class UserIsAuthenticatedWithTwitterTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = ApiCurious::Application
    stub_omniauth
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

  test "user can log out and log in using twitter" do
    login_user
    click_link "Log out"

    old_user_count = User.count

    assert_equal root_path, current_path
    assert page.has_content?("You have successfully logged out.")

    visit feed_path

    assert_equal root_path, current_path

    login_user

    assert_equal 0, User.count - old_user_count
    assert page.has_content?("Candy Cat")
    assert page.has_content?("@candy")
  end
end
