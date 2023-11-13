require "test_helper"

class DepartmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @department = departments(:department)
  end

  teardown do
    Rails.cache.clear
  end

  test "部署を新規投稿し、データが一つ増加している" do
    assert_difference("Department.count",+1) do
      post departments_path, params: {
        department: {
          name: "部署名"
        }
      }
      assert_response :redirect
    end
  end

  test "部署を更新し、データ数が変化していない" do
    assert_no_difference("Department.count") do
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

  test "対象の部署データを削除し、データ数が1つ減少している" do
    assert_difference("Department.count", -1) do
      delete department_url(@department)
    end
  end
end
