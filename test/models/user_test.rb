require "test_helper"

class UserTest < ActiveSupport::TestCase

  setup do
    # テスト環境の日付を4月2日に設定
    Timecop.freeze(Date.new(Date.current.year, 4, 2))
  end
  
  teardown do
    # Timecopで設定した日付をリセット
    Timecop.return
  end

  test "全項目の入力のない投稿を保存しない" do
    user = User.new
    assert_not user.save, "Saved the user without a name"
  end

  test "基準日によって18歳以上になっていないことの検出" do
    under_18_person = User.new(
      name: "佐藤智希",
      hiragana_nama: "サトウトモキ",
      sex: "男性",
      tel: "00-000-0000",
      mobile: "000-0000-0000",
      mail: "example@example.com",
      postcode: "000-0000",
      address1: "宮城県",
      address2: "栗原市",
      address3: "栗駒",
      address4: "沼倉",
      birthday: Date.new(2005, 4, 3)
    )
    assert_not under_18_person.valid?  # 18歳未満の人はバリデーションエラーが発生
  end

  test "基準日によって18歳以上になっていることを検出" do
    over_18_person = User.new(
      name: "佐藤智希",
      hiragana_nama: "サトウトモキ",
      sex: "男性",
      tel: "111-000-0000",
      mobile: "111-0000-0000",
      mail: "111example@example.com",
      postcode: "000-0000",
      address1: "宮城県",
      address2: "栗原市",
      address3: "栗駒",
      address4: "沼倉",
      birthday: Date.new(2005, 4, 1)
    )  
    assert over_18_person.valid?     # 18歳以上の人はバリデーションエラーが発生しない
  end
end
