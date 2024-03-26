require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user)
  end

  teardown do
    Rails.cache.clear
  end

  test "存在しているメールアドレスでログインできている" do
    get admin_session_url
    post admin_session_url, params: {
      session: {
      mail: @user.mail.downcase
      }
    }
    assert_redirected_to admin_user_path(@user)
  end

  test "ログイン状態からログアウトができている" do
    get admin_session_url
    post admin_session_url, params: {
      session: {
      mail: @user.mail.downcase
      }
    }
    delete logout_url
    assert_nil session[:user_id]
  end

end
