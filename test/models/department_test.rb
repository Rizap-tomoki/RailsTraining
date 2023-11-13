require "test_helper"

class DepartmentTest < ActiveSupport::TestCase

  setup do
    @department = departments(:department)
  end
  
  teardown do
    Rails.cache.clear
  end

  test "Departmentモデルが複数のUserモデルと正しく関連している" do
    assert_respond_to @department, :users
  end

  test "Departmentに関連する全てのUserが正しい部署に所属している" do
    @department.users.each do |user|
      assert_equal @department.id, user.department_id
    end
  end
  
end
