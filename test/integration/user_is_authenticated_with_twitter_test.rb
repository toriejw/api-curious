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
        extra: { raw_info: { id_str: "1234",
                             nickname: "candy",
                             name: "Candy Cat" } } })
  end

  test "visitor can create account using twitter" do
    visit root_path
    click_link "Log In"

    assert_equal feed_path, current_path
    save_and_open_page
    assert page.has_content?("Candy Cat")
    assert page.has_content?("@candy")
  end

  test "user can login using twitter" do
    skip
    # login_user
  end
end
