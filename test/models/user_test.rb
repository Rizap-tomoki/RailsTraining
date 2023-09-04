require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end
  test "should not save user without name" do
    user = User.new
    assert_not user.save, "Saved the user without a name"
  end
  test "should report error" do
    # some_undefined_variableはテストケースのどこにも定義されていない
    assert_raises(NameError) do
      some_undefined_variable
    end
  end
end
