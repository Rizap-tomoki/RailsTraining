require "test_helper"

class SkillTest < ActiveSupport::TestCase

  setup do
    @skill = skills(:skill)
    @user_skill = user_skills(:user_skill)
  end
  
  teardown do
    Rails.cache.clear
  end

  #中間テーブル（user_skill）とのアソシエーション
  test "skillsテーブルが複数のuser_skillsテーブルと関連している" do
    assert_respond_to @skill, :user_skills
  end
  test "skill.idが中間テーブル（user_skill）の外部キー連携している" do
    assert_equal @skill.id, @user_skill.skill_id
  end
  
  #userテーブルとのアソシエーション
  test "skillsテーブルが複数のusersテーブルと関連している" do
    assert_respond_to @skill, :users
  end
end
