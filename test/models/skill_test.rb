require "test_helper"

class SkillTest < ActiveSupport::TestCase

  setup do
    @skill = skills(:skill)
  end
  
  teardown do
    Rails.cache.clear
  end

  #userテーブルとのアソシエーション
  test "skillsテーブルが複数のusersテーブルと関連している" do
    assert_respond_to @skill, :users
  end
end
