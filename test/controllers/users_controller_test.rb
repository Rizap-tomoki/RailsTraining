require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  # 各テストの実行後に呼ばれる
  teardown do
    # コントローラがキャッシュを使っている場合、テスト後にリセットしておくとよい
    Rails.cache.clear
  end

  test "should get index" do
    get user_url(@user)
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { name: "Some name" } }
    end
  
    assert_redirected_to user_path(User.last)
    assert_equal "User was successfully created.", flash[:notice]
    
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { name: "updated" } }
    assert_redirected_to user_path(@user)
    @user.reload
    assert_equal "updated", @user.name
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_path
  end

  test "ajax request" do
    user = users(:one)
    get user_url(user), xhr: true
  
    assert_equal "hello world", @response.name
    assert_equal "text/javascript", @response.media_type
  end
end
