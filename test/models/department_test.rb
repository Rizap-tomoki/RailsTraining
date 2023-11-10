require "test_helper"

class DepartmentTest < ActiveSupport::TestCase

  setup do
    @department = departments(:department)
  end
  
  teardown do
    Rails.cache.clear
  end

  test "Userとのアソシエーションの確認" do
    # 関連性を確認
    assert_respond_to @department, :users
    assert_instance_of ActiveRecord::Associations::CollectionProxy, @department.users

    # ユーザーが正しく関連付けられているか確認
    assert_not_empty @department.users
    @department.users.each do |user|
      assert_equal @department.id, user.department_id
    end
  end
end
