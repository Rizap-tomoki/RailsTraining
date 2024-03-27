require "rails_helper"

RSpec.describe "sessionのシステムテスト", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  it "ログイン画面から正当なメールアドレスでログインし、ログイン状態の画面に遷移されている" do
    visit new_admin_session_path
    fill_in "Mail", with: @user.mail
    click_on "ログイン"
    assert_selector "h1", text: "こんにちは#{@user.name}さん"
  end

  it "ログイン画面から不正メールアドレスでログインし、メッセージが表示されている" do
    visit new_admin_session_path
    fill_in "Mail", with: "false_email@example.com"
    click_on "ログイン"
    expect(page).to have_text("メールアドレスが間違っています")
  end

  it "ログアウトして、ログアウト状態の画面に遷移されている" do
    visit new_admin_session_path
    fill_in "Mail", with: @user.mail
    click_on "ログイン"
    click_link '管理者画面からログアウト'
    assert_selector "h1", text: "みなさんこんにちは"
  end

end
