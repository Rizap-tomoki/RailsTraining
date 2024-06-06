require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:google_user)
    @auth_hash = {
      'provider' => 'google_oauth2',
      'uid' => '123545',
      'info' => {
        'email' => 'example@rizapgroup.com'
      }
    }
  end

  teardown do
    Rails.cache.clear
  end

  test "OmniAuthを使用してログインできている" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(@auth_hash)
    get '/auth/google_oauth2/callback'

    assert_equal @user.id, session[:current_user_id]
    assert_redirected_to admin_users_path
  end

  test "無効なOmniAuth認証情報を使用してログインできていない" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials

    get '/auth/google_oauth2/callback'
    assert_response :found
    assert_nil session[:current_user_id]
  end
end