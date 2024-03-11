require "rails_helper"

RSpec.describe "userのシステムテスト", type: :system do
  before do
    @department = FactoryBot.create(:department, name: '新しい部署')
    @user = FactoryBot.create(:user, department: @department)
    @skill = FactoryBot.create(:skill, name: '新しいスキル')
    @user.skills << @skill
  end

  
  it "ユーザー詳細画面の検出" do
    visit admin_user_path(@user)
    expect(page).to have_content('部署名: 新しい部署')
    expect(page).to have_content('名前: テストユーザー')
    expect(page).to have_content('フリガナ: テストユーザー')
    expect(page).to have_content('新しいスキル')
    expect(page).to have_content('性別: 男性')
    expect(page).to have_content('電話: 123-4567-8901')
    expect(page).to have_content('携帯電話: 987-6543-2109')
    expect(page).to have_content('郵便番号: 123-4567')
    expect(page).to have_content('メールアドレス: test@example.com')
    expect(page).to have_content('住所1: 宮城県')
    expect(page).to have_content('住所2: 新しい市')
    expect(page).to have_content('住所3: 新しい町')
    expect(page).to have_content('住所4: 新しい住所')
    expect(page).to have_content('住所5: 新しい番地')
    expect(page).to have_content('誕生日: 2000-01-01')
    expect(page).to have_selector("img[src='test_image.jpg']")
  end

  it "部署名を作成し、作成した部署名でユーザー投稿を行う" do
    #部署名を投稿
    visit new_admin_department_path
    text_field = find('input[type="text"]')
    expect(text_field.value).to be_empty
    fill_in "名前", with: "テスト部署"
    click_button "送信"

    #部署名をもとにユーザー投稿
    visit new_user_path
    all_text_fields = all('input[type="text"]')
    all_text_fields.each do |text_field|
      expect(text_field.value).to be_empty
    end
    expect(page).to have_css('input[type="radio"][checked="checked"]', count: 0)
    fill_in "名前", with: "新しい名前"
    fill_in "フリガナ", with: "アタラシイナマエ"
    select "男性", from: "性別"
    fill_in "電話番号", with: "120-4567-8901"
    fill_in "携帯電話番号", with: "980-6543-2109"
    fill_in "郵便番号", with: "120-4567"
    fill_in "メールアドレス", with: "new_email@example.com"
    select "神奈川県", from: "住所1"
    fill_in "住所2", with: "新しい市"
    fill_in "住所3", with: "新しい町"
    fill_in "住所4", with: "新しい住所"
    fill_in "住所5", with: "新しい番地"
    fill_in "誕生日", with: "01-01-2001"
    select "テスト部署", from: 'user_department_id'
    click_button "送信"

    #投稿内容の確認
    expect(page).to have_content('部署名: テスト部署')
  end

  it "スキルを作成し、作成したスキルでユーザー投稿を行う" do
    #スキル名を投稿
    visit new_admin_skill_path
    text_field = find('input[type="text"]')
    expect(text_field.value).to be_empty
    fill_in "名前", with: "テストスキル"
    click_button "送信"

    #スキル名をもとにユーザー投稿
    visit new_admin_user_path
    all_text_fields = all('input[type="text"]')
    all_text_fields.each do |text_field|
      expect(text_field.value).to be_empty
    end
    expect(page).to have_css('input[type="radio"][checked="checked"]', count: 0)
    fill_in "名前", with: "新しい名前"
    fill_in "フリガナ", with: "アタラシイナマエ"
    select "男性", from: "性別"
    fill_in "電話番号", with: "123-4567-8900"
    fill_in "携帯電話番号", with: "987-6543-2100"
    fill_in "郵便番号", with: "123-4567"
    fill_in "メールアドレス", with: "new_email@example.com"
    select "神奈川県", from: "住所1"
    fill_in "住所2", with: "新しい市"
    fill_in "住所3", with: "新しい町"
    fill_in "住所4", with: "新しい住所"
    fill_in "住所5", with: "新しい番地"
    fill_in "誕生日", with: "01-01-2001"
    select "新しい部署", from: 'user_department_id'
    skill = Skill.find_by(name: "テストスキル")
    check "user[skill_ids][]", option: skill.id
    click_button "送信"

    #投稿内容の確認
    expect(page).to have_content('テストスキル')
  end

  it "ユーザープロフィール情報を編集し、編集されたデータが表示されている" do
    #編集ページに移動し、データを入力
    visit edit_admin_user_path(@user)
    image_path = Rails.root.join('spec', 'image', 'test_image.jpg')
    attach_file('desk[image]', image_path, make_visible: true)
    fill_in "名前", with: "新しい名前"
    fill_in "フリガナ", with: "アタラシイナマエ"
    select "女性", from: "性別"
    fill_in "電話番号", with: "123-4567-8901"
    fill_in "携帯電話番号", with: "987-6543-2109"
    fill_in "郵便番号", with: "123-4567"
    fill_in "メールアドレス", with: "new_email@example.com"
    select "神奈川県", from: "住所1"
    fill_in "住所2", with: "新しい市"
    fill_in "住所3", with: "新しい町"
    fill_in "住所4", with: "新しい住所"
    fill_in "住所5", with: "新しい番地"
    fill_in "誕生日", with: "01-01-2000"
    select "新しい部署", from: 'user_department_id'
    skill_id = Skill.first.id 
    check "user[skill_ids][]", option: skill_id
    click_button "送信"
    
    #編集されたデータが正しくレンダリングされているか確認
    expect(page).to have_content('新しい部署')
    expect(page).to have_content('新しい名前')
    expect(page).to have_content('アタラシイナマエ')
    expect(page).to have_content('女性')
    expect(page).to have_content('新しいスキル')
    expect(page).to have_content('123-4567-8901')
    expect(page).to have_content('123-4567')
    expect(page).to have_content('new_email@example.com')
    expect(page).to have_content('神奈川県')
    expect(page).to have_content('新しい市')
    expect(page).to have_content('新しい町')
    expect(page).to have_content('新しい住所')
    expect(page).to have_content('新しい番地')
    expect(page).to have_content('2000-01-01')
    expect(page).to have_selector("img[src$='test_image.jpg']")

  end

  it "ユーザープロフィール情報の削除し、既存のデータが表示されていない" do
    visit admin_user_path(@user)
    accept_confirm do
      click_link "Destroy"
    end
    expect(page).not_to have_content('テストユーザー')
  end
  
  it "ユーザープロフィール情報の削除をキャンセル、既存のデータが表示されている" do
    visit admin_user_path(@user)
    dismiss_confirm do
      click_link "Destroy"
    end
    expect(page).to have_content('テストユーザー')
  end

  it "ログイン画面から正当なメールアドレスでログインし、ログイン状態の画面に遷移されている" do
    visit login_path
    fill_in "Mail", with: @user.mail
    click_on "ログイン"
    assert_selector "h1", text: "こんにちは#{@user.name}さん"
  end

  it "ログイン画面から不正メールアドレスでログインし、メッセージが表示されている" do
    visit login_path
    fill_in "Mail", with: "false_email@example.com"
    click_on "ログイン"
    expect(page).to have_text("メールアドレスが間違っています")
  end

  it "ログアウトして、ログアウト状態の画面に遷移されている" do
    visit login_path
    fill_in "Mail", with: @user.mail
    click_on "ログイン"
    click_link '管理者画面からログアウト'
    assert_selector "h1", text: "みなさんこんにちは"
  end

end
