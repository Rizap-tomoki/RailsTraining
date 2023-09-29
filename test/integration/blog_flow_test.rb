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
        tel: "00-0000-0000",
        mobile: "000-0000-0000",
        mail: "example@example.com",
        postcode: "000-0000",
        address1: "宮城県",
        address2: "栗原市",
        address3: "栗駒",
        address4: "沼倉",
        address5: "日照田3",
        birthday: "2001-03-14"
      }
    }
    follow_redirect!
    assert_response :success
    assert_select  "label", "名前:佐藤智希"
    assert_select  "label", "フリガナ:サトウトモキ"
    assert_select  "label", "性別:男性"
    assert_select  "label", "電話:00-0000-0000"
    assert_select  "label", "携帯電話:000-0000-0000"
    assert_select  "label", "郵便番号:000-0000"
    assert_select  "label", "メールアドレス:example@example.com"
    assert_select  "label", "住所1:宮城県"
    assert_select  "label", "住所2:栗原市"
    assert_select  "label", "住所3:栗駒"
    assert_select  "label", "住所4:沼倉"
    assert_select  "label", "住所5:日照田3"
    assert_select "label", "誕生日:2001-03-14"
  end
  
end
