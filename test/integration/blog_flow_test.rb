require "test_helper"

class BlogFlowTest < ActionDispatch::IntegrationTest
  test "rootページでh1タグでUsers表示のシュミレート" do
    get "/"
    assert_select "h1", "Users"
  end
  test "user投稿テストのシュミレート" do
    get "/users/new"
    assert_response :success
  
    post "/users",
      params: { user: { name: "can create" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h1", "Name:  can create"
  end
  
end
