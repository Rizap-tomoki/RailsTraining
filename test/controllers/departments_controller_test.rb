require "test_helper"

class DepartmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @department = departments(:department)
  end

  teardown do
    # コントローラがキャッシュを使っている場合、テスト後にリセットしておくとよい
    Rails.cache.clear
  end

  test "部署名投稿確認テスト" do
    assert_difference("Department.count",+1) do
      post departments_path, params: {
        department: {
          name: "部署名"
        }
      }
      assert_response :redirect
    end
  end

  test "部署名変更の確認テスト" do
    assert_no_difference("User.count") do
      patch department_url(@department), params: {
        department: {
          name: "新しい部署名"
        }
      }
      assert_redirected_to department_path(@department)
      @department.reload
      assert_equal "新しい部署名", @department.name
    end
  end

  test "部署削除" do
    assert_difference("Department.count", -1) do
      delete department_url(@department)
    end
  end
end
