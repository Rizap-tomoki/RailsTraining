require "test_helper"

class SkillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @skill = skills(:skill)
  end

  teardown do
    Rails.cache.clear
  end

  test "スキルを新規投稿し、データが一つ増加している" do
    assert_difference("Skill.count",+1) do
      post skills_path, params: {
        skill: {
          name: "テストスキル名"
        }
      }
      assert_response :redirect
    end
  end

  test "スキルを更新し、データ数が変化していない" do
    assert_no_difference("Skill.count") do
      patch skill_url(@skill), params: {
        skill: {
          name: "新しいスキル名"
        }
      }
      assert_redirected_to skill_path(@skill)
      @skill.reload
      assert_equal "新しいスキル名", @skill.name
    end
  end

  test "対象のスキルデータを削除し、データ数が1つ減少している" do
    assert_difference("Skill.count", -1) do
      delete skill_url(@skill)
    end
  end
end
