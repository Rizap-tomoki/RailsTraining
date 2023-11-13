require "test_helper"

class UserDepartmentIntegrationTest < ActionDispatch::IntegrationTest
  test "部署名を作成し、作成した部署名でユーザー投稿を行う" do
    # 部署名を作成
    post departments_path, params: {
      department: {
        name: "新しい部署"
      }
    }
    assert_response :redirect
    department = Department.last
    # ユーザー投稿
    post users_url, params: {
      user: {
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
        department_id: department.id
      }
    }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end
