require "application_system_test_case"


class UsersTest < ApplicationSystemTestCase
  driven_by :selenium, using: :chrome

  test "viewing the index" do
    visit articles_path
    assert_selector "h1", text: "Users"
  end
end
