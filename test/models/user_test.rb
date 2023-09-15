require "test_helper"

class UserTest < ActiveSupport::TestCase
  def test_the_truth
    assert true
  end
  test "名前のないuserを保存しない" do
    user = User.new
    assert_not user.save, "Saved the user without a name"
  end
  test "エラーの表示" do
    # some_undefined_variableはテストケースのどこにも定義されていない
    assert_raises(NameError) do
      some_undefined_variable
    end
  end
end
