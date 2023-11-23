require "test_helper"

class UserSkillTest < ActiveSupport::TestCase

  setup do
    @user = users(:user)
    @skill = skills(:skill)
    @user_skill = user_skills(:user_skill)
  end
  
  teardown do
    Rails.cache.clear
  end

  #skillテーブルとのアソシエーション
  test "user_skillsテーブルが1つのskillsテーブルと関連している" do
    assert_respond_to @user_skill, :skill
  end
  test "user_skillsテーブルの外部キーがskill.idと関連している" do
    assert_equal @user_skill.skill_id, @skill.id
  end
  
  #userテーブルとのアソシエーション
  test "user_skillsテーブルが1つのusersテーブルと関連している" do
    assert_respond_to @user_skill, :user
  end
  test "user_skillsテーブルの外部キーがuser.idと関連している" do
    assert_equal @user_skill.user_id, @user.id
  end

end
