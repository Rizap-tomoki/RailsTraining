require "test_helper"

class UserTest < ActiveSupport::TestCase

  setup do
    @department = departments(:department)
    @user = users(:user)
    @skill = skills(:skill)
    # テスト環境の日付を4月2日に設定
    Timecop.freeze(('2023-04-02'))
  end
  
  teardown do
    # Timecopで設定した日付をリセット
    Timecop.return
    Rails.cache.clear
  end

  #departmentsテーブルとのアソシエーション
  test "userの外部キーと部署idが紐づいている" do
    assert_equal  @user.department_id, @department.id
  end
  test "usersテーブルが1つのdepartmentsテーブルと関連している" do
    assert_respond_to @user, :department
  end

  #skillsテーブルとのアソシエーション
  test "usersテーブルが複数のskillsテーブルと関連している" do
    assert_respond_to @user, :skills
  end

  test "全項目の入力のない投稿を保存しない" do
    user = User.new
    assert_not user.save, "Saved the user without a name"
  end

  test "基準日によって18歳以上になっていないことの検出" do
    under_18_person = User.new(
      name: "佐藤智希",
      hiragana_nama: "サトウトモキ",
      department_id: @department.id,
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
    assert_not under_18_person.valid?
  end

  test "基準日によって18歳以上になっていることを検出" do
    over_18_person = User.new(
      name: "佐藤智希",
      hiragana_nama: "サトウトモキ",
      department_id: @department.id,
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
    over_18_person.errors.full_messages if over_18_person.invalid?
    assert over_18_person.valid?
  end

  test "誕生日が未来でないことを確認する" do
    user = User.new(birthday: Date.tomorrow)
    assert_not user.valid?
    assert_includes user.errors[:birthday], "未来の日付になっています"
  end

  test '存在しない部署IDの場合は無効であることを確認する' do
    user = User.new(department_id: 999)
    assert_not user.valid?
    assert_includes user.errors[:department_id], '選択された部署が存在しません'
  end

  # パスワードのバリデーションテスト
  test "パスワードは空白であってはならない" do
    user = User.new(password: "", password_confirmation: "password")
    assert_not user.valid?
  end

  test "パスワードは8文字以上である必要があります" do
    user = User.new(password: "pass", password_confirmation: "pass")
    assert_not user.valid?
  end

  test "パスワードには英字と数字の両方が含まれる必要があります" do
    user = User.new(password: "password", password_confirmation: "password")
    assert_not user.valid?
  end

  test "有効なパスワード" do
    user = User.new(
      name: "佐藤智希",
      hiragana_nama: "サトウトモキ",
      department_id: @department.id,
      sex: "男性",
      tel: "00-000-1111",
      mobile: "000-0000-1111",
      mail: "example1@example1.com",
      password: "password123",
      password_confirmation: "password123",
      postcode: "000-0000",
      address1: "宮城県",
      address2: "栗原市",
      address3: "栗駒",
      address4: "沼倉",
      birthday: Date.new(2000, 4, 3)
    )
   assert user.valid?
  end
end
