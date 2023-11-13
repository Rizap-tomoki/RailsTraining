require "test_helper"

class UserDepartmentIntegrationTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:user)
    @department = departments(:department)
  end
  
  teardown do
    Rails.cache.clear
  end

  test "ユーザーと部署の結合テスト" do
    assert_includes @department.users, @user
  end

end
