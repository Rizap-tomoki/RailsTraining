require "rails_helper"

RSpec.describe "タグ検出とプロフィール更新のテスト", type: :system do
  let(:user) { FactoryBot.create(:user) }

  it "rootパスでh1タグのUserを検出" do
    visit root_path
    expect(page).to have_content "Users"
  end

  it "ユーザープロフィール情報を編集" do
    user_id = user.id
    visit edit_user_path(user_id)
    fill_in "名前", with: "新しい名前"
    fill_in "フリガナ", with: "シンキナマエ"
    choose "女性"
    fill_in "電話番号", with: "123-4567-8901"
    fill_in "携帯電話番号", with: "987-6543-2109"
    fill_in "郵便番号", with: "123-4567"
    fill_in "メールアドレス", with: "new_email@example.com"
    select "神奈川県", from: "住所1"
    fill_in "住所2", with: "新しい市"
    fill_in "住所3", with: "新しい町"
    fill_in "住所4", with: "新しい住所"
    fill_in "住所5", with: "新しい番地"
    fill_in "誕生日", with: "2000-01-01"
    click_button "送信"
  end
end
