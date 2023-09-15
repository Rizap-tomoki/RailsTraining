require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tanaka = users(:tanaka)
  end

  # 各テストの実行後に呼ばれる
  teardown do
    # コントローラがキャッシュを使っている場合、テスト後にリセットしておくとよい
    Rails.cache.clear
  end

  test "indexアクションにリクエストし、レスポンスが正常にアクセスできるか確認するテスト" do
    get user_url(@tanaka)
    assert_response :success
  end

  test "newアクションにリクエストし、レスポンスが正常にアクセスできるか確認するテスト" do
    get new_user_url
    assert_response :success
  end

  test "Userのカウントが増加し、適切なリダイレクトが行われることを確認するテスト" do
    assert_difference("User.count") do
      post users_url, params: { user: { name: "田中" } }
    end
    assert_redirected_to user_path(User.last)
  end

  test "showアクションにリクエストし、レスポンスが正常にアクセスできるか確認するテスト" do
    get user_url(@tanaka)
    assert_response :success
  end

  test "editアクションにリクエストし、レスポンスが正常にアクセスできるか確認するテスト" do
    get edit_user_url(@tanaka)
    assert_response :success
  end

  test "リダイレクト、データベースへの変更、およびデータの一致を検証するテスト" do
    patch user_url(@tanaka), params: { user: { name: "updated" } }
    assert_redirected_to user_path(@tanaka)
    @tanaka.reload
    assert_equal "updated", @tanaka.name
  end

  test "Userのカウントが減少し、rootパスにリダイレクトが行われることを確認するテスト" do
    assert_difference("User.count", -1) do
      delete user_url(@tanaka)
    end

    assert_redirected_to root_path
  end

  
end
