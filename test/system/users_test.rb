require "application_system_test_case"


class UsersTest < ApplicationSystemTestCase
  driven_by :selenium, using: :chrome

  test "viewing the index" do
    visit users_path
    assert_selector "h1", text: "Users"
  end
end
