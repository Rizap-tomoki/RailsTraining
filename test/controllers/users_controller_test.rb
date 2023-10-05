require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user)
  end

  # 各テストの実行後に呼ばれる
  teardown do
    # コントローラがキャッシュを使っている場合、テスト後にリセットしておくとよい
    Rails.cache.clear
  end

  test "indexアクションにリクエストし、レスポンスが正常にアクセスできるか確認するテスト" do
    get users_url
    assert_response :success
  end

  test "newアクションにリクエストし、レスポンスが正常にアクセスできるか確認するテスト" do
    get new_user_url
    assert_response :success
  end

  test "User投稿確認テスト" do
    assert_difference("User.count") do
      post users_url, params: {
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
    end
    assert_redirected_to user_path(User.last)
  end

  test "showアクションにリクエストし、レスポンスが正常にアクセスできるか確認するテスト" do
    get user_url(@user)
    assert_response :success
  end

  test "editアクションにリクエストし、レスポンスが正常にアクセスできるか確認するテスト" do
    get edit_user_url(@user)
    assert_response :success
    # ビューテスト
    assert_select "h1","Edit User"
  end

  test "リダイレクト、データベースへの変更、およびデータの一致を検証するテスト" do
    patch user_url(@user), params: {
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
        birthday: "2000-01-01"
      }
    }
    assert_redirected_to user_path(@user)
    @user.reload
    assert_equal "新しい名前", @user.name
    assert_equal "アタラシイヒラガナ", @user.hiragana_nama
    assert_equal "女性", @user.sex
    assert_equal "111-1111-1111", @user.tel
    assert_equal "222-2222-2222", @user.mobile
    assert_equal "new@example.com", @user.mail
    assert_equal "123-4567", @user.postcode
    assert_equal "神奈川県", @user.address1
    assert_equal "新しい市", @user.address2
    assert_equal "新しい町", @user.address3
    assert_equal "新しい住所", @user.address4
    assert_equal "新しい番地", @user.address5
    assert_equal "2000-01-01", @user.birthday.to_s
  end

  test "Userのカウントが減少し、rootパスにリダイレクトが行われることを確認するテスト" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to root_path
  end

  test "indexページでユーザー名をクリックしてユーザーのshowページに移動することを確認するテスト" do
   get users_path

   assert_select "a[href=?]", user_path(@user), text: @user.name

   get user_path(@user)

   assert_response :success

   assert_select "h1", text: "個人情報詳細ページ"
   assert_select "div.userdetail" do
     assert_select "label", 13
   end
 end

  
end
