require "test_helper"

class BlogFlowTest < ActionDispatch::IntegrationTest
  test "rootページでh1タグでUsers表示のシュミレート" do
    get "/"
    assert_select "h1", "Users"
  end
  test "user投稿が表示できているかテスト" do
    get "/users/new"
    assert_response :success
  
    post "/users",
    params: {
      user: {
        name: "佐藤智希",
        hiragana_nama: "サトウトモキ",
        sex: "男性", 
        tel: "11-1111-1111",
        mobile: "222-2222-2222",
        mail: "new@example.com",
        postcode: "123-4567",
        address1: "神奈川県",
        address2: "新しい市",
        address3: "新しい町",
        address4: "新しい住所",
        address5: "新しい番地",
        birthday: "2000-01-01"
      }
    }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select  "label", "名前:佐藤智希"
    assert_select  "label", "フリガナ:サトウトモキ"
    assert_select  "label", "性別:男性"
    assert_select  "label", "電話:11-1111-1111"
    assert_select  "label", "携帯電話:222-2222-2222"
    assert_select  "label", "郵便番号:123-4567"
    assert_select  "label", "メールアドレス:new@example.com"
    assert_select  "label", "住所1:神奈川県"
    assert_select  "label", "住所2:新しい市"
    assert_select  "label", "住所3:新しい町"
    assert_select  "label", "住所4:新しい住所"
    assert_select  "label", "住所5:新しい番地"
    assert_select  "label", "誕生日:2000-01-01"
  end
  
end
