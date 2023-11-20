require "rails_helper"

RSpec.describe "userコントローラのシステムテスト", type: :system do
  let(:department) { FactoryBot.create(:department) }
  let(:user) { FactoryBot.create(:user, department: department) }
  
  it "ユーザー詳細画面の検出" do
    visit user_path(user)
    expect(page).to have_content('部署名: 新しい部署')
    expect(page).to have_content('名前: テストユーザー')
    expect(page).to have_content('フリガナ: テストユーザー')
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
  end

  it "部署名を作成し、作成した部署名でユーザー投稿を行う" do
    #部署名を投稿
    visit new_department_path
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
    fill_in "電話番号", with: "123-4567-8901"
    fill_in "携帯電話番号", with: "987-6543-2109"
    fill_in "郵便番号", with: "123-4567"
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
    expect(page).to have_content('名前: 新しい名前')
    expect(page).to have_content('フリガナ: アタラシイナマ')
    expect(page).to have_content('性別: 男性')
    expect(page).to have_content('電話: 123-4567-8901')
    expect(page).to have_content('携帯電話: 987-6543-2109')
    expect(page).to have_content('郵便番号: 123-4567')
    expect(page).to have_content('メールアドレス: new_email@example.com')
    expect(page).to have_content('住所1: 神奈川県')
    expect(page).to have_content('住所2: 新しい市')
    expect(page).to have_content('住所3: 新しい町')
    expect(page).to have_content('住所4: 新しい住所')
    expect(page).to have_content('住所5: 新しい番地')
    expect(page).to have_content('誕生日: 2001-01-01')
  end

  it "ユーザープロフィール情報を編集し、正しいレンダリングがされている" do
    #編集ページに移動し、データを入力
    visit edit_user_path(user.id)
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
    click_button "送信"
    
    #編集されたデータが正しくレンダリングされているか確認
    expect(page).to have_content('新しい部署')
    expect(page).to have_content('新しい名前')
    expect(page).to have_content('アタラシイナマエ')
    expect(page).to have_content('女性')
    expect(page).to have_content('123-4567-8901')
    expect(page).to have_content('123-4567')
    expect(page).to have_content('new_email@example.com')
    expect(page).to have_content('神奈川県')
    expect(page).to have_content('新しい市')
    expect(page).to have_content('新しい町')
    expect(page).to have_content('新しい住所')
    expect(page).to have_content('新しい番地')
    expect(page).to have_content('2000-01-01')
  end

  it "ユーザープロフィール情報の削除し、正しいレンダリングがされている" do
    visit user_path(user)
    accept_confirm do
      click_link "Destroy"
    end
    expect(page).not_to have_content('テストユーザー')
  end
  
  it "ユーザープロフィール情報の削除をキャンセル、正しいレンダリングがされている" do
    visit user_path(user)
    dismiss_confirm do
      click_link "Destroy"
    end
    expect(page).to have_content('テストユーザー')
  end

end
