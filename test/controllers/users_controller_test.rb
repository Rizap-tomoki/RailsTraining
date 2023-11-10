require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user)
    @department = Department.create(name: "部署名")
  end

  # 各テストの実行後に呼ばれる
  teardown do
    # コントローラがキャッシュを使っている場合、テスト後にリセットしておくとよい
    Rails.cache.clear
  end

  test "User投稿確認テスト" do
    assert_difference("User.count",+1) do
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
        department_id: @department.id
      }
    }
      assert_response :redirect
    end
  end


  test "リダイレクト、データベースへの変更、およびデータの一致を検証するテスト" do
    assert_no_difference("User.count") do
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
          birthday: "2000-01-01",
          department_id: @department.id
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
      assert_equal "2", @user.department_id
    end
  end

  test "User削除確認テスト" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end
  end

  test "indexページに正しいタグが存在している確認" do
    get root_path
    assert_response :success
    assert_select 'h1',text: '従業員管理サイト'
  end

  test "newページに正しいタグが存在している確認" do
    get new_user_path
    assert_response :success
    assert_select 'h1',text: '従業員情報登録画面'
    assert_select "div.user_form" do
      assert_select "label",text: '名前'
      assert_select "label",text: 'フリガナ'
      assert_select "label",text: '性別'
      assert_select "label",text: '電話番号'
      assert_select "label",text: '携帯電話番号'
      assert_select "label",text: '郵便番号'
      assert_select "label",text: 'メールアドレス'
      assert_select "label",text: '住所1'
      assert_select "label",text: '住所2'
      assert_select "label",text: '住所3'
      assert_select "label",text: '住所4'
      assert_select "label",text: '住所5'
      assert_select "label",text: '誕生日' 
    end
  end

  test "showページに正しいタグが存在している確認" do
    get user_url(@user)
    assert_response :success
    assert_select 'h1',text: '従業員情報詳細ページ'
    assert_select "div.userdetail" do
      assert_select "label",text: '名前:佐藤智希'
      assert_select "label",text: 'フリガナ:サトウトモキ'
      assert_select "label",text: '性別:男性'
      assert_select "label",text: '電話:00-000-0000'
      assert_select "label",text: '携帯電話:000-0000-0000'
      assert_select "label",text: '郵便番号:000-0000'
      assert_select "label",text: 'メールアドレス:example@example.com'
      assert_select "label",text: '住所1:宮城県'
      assert_select "label",text: '住所2:栗原市'
      assert_select "label",text: '住所3:栗駒'
      assert_select "label",text: '住所4:沼倉'
      assert_select "label",text: '住所5:日照田3'
      assert_select "label",text: '誕生日:2000-01-01' 
    end
  end

  test "editページに正しいタグが存在している確認" do
    get edit_user_path(@user)
    assert_response :success
    assert_select 'h1',text: '従業員情報編集画面'
    assert_select "div.user_form" do
      assert_select "label",text: '名前'
      assert_select "label",text: 'フリガナ'
      assert_select "label",text: '性別'
      assert_select "label",text: '電話番号'
      assert_select "label",text: '携帯電話番号'
      assert_select "label",text: 'メールアドレス'
      assert_select "label",text: '住所1'
      assert_select "label",text: '住所2'
      assert_select "label",text: '住所3'
      assert_select "label",text: '住所4'
      assert_select "label",text: '住所5'
      assert_select "label",text: '誕生日' 
    end
  end
  
end
