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

  test "indexアクションにリクエストをシュミレート" do
    get user_url(@tanaka)
    assert_response :success
  end

  test "newアクションにリクエストをシュミレート" do
    get new_user_url
    assert_response :success
  end

  test "createアクションにリクエストをシュミレート" do
    assert_difference("User.count") do
      post users_url, params: { user: { name: "田中" } }
    end
  
    assert_redirected_to user_path(User.last)
    assert_equal "User was successfully created.", flash[:notice]
    
  end

  test "showアクションにリクエストをシュミレート" do
    get user_url(@tanaka)
    assert_response :success
  end

  test "editアクションにリクエストをシュミレート" do
    get edit_user_url(@tanaka)
    assert_response :success
  end

  test "updateアクションにリクエストをシュミレート" do
    patch user_url(@tanaka), params: { user: { name: "updated" } }
    assert_redirected_to user_path(@tanaka)
    @tanaka.reload
    assert_equal "updated", @tanaka.name
  end

  test "destroyアクションにリクエストをシュミレート" do
    assert_difference("User.count", -1) do
      delete user_url(@tanaka)
    end

    assert_redirected_to root_path
  end

  
end
