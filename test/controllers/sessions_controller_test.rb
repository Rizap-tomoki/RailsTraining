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

  test "Google認証が正しいメールアドレスで認証している" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(@auth_hash)
    get '/auth/google_oauth2/callback'

    assert_equal @user.id, session[:current_user_id]
    assert_redirected_to admin_users_path
  end

  test "Google認証が不正のメールアドレスで認証していない" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(@auth_hash)

    @user.destroy
    get '/auth/google_oauth2/callback'

    assert_nil session[:current_user_id]
    assert_equal "Google認証に失敗しました。ユーザーが登録されていません。", flash[:alert]
    assert_response :unauthorized
  end
end