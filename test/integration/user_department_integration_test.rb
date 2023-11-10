require "test_helper"

class UserDepartmentIntegrationTest < ActionDispatch::IntegrationTest

  test "ユーザーと部署の結合テスト" do
    department = Department.create(name: "部署名")
    user = User.create(
      name: "新しい名前",
        hiragana_nama: "アタラシイヒラガナ",
        sex: "女性", 
        tel: "111-1111-1111",
        mobile: "222-2222-2222",
        mail: "new@example.com",
        postcode: "123-4567",
        address1: "神奈川県",
        address2: "新しい市",
        address3: "新しい町",
        address4: "新しい住所",
        address5: "新しい番地",
        birthday: "2000-01-01",
        department: department
    )
    assert_equal department, user.department
    assert_includes department.users, user
  end

end
