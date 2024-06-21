require "rails_helper"

RSpec.describe "sessionのシステムテスト", type: :system do
  let(:user) { FactoryBot.create(:user) }

  it "ログイン画面から正当なメールアドレス・パスワードでログインし、ログイン状態の画面に遷移されている" do
    visit new_admin_session_path
    fill_in "Mail", with: user.mail
    fill_in "Password", with: user.password
    click_on "ログイン"
    assert_selector "h1", text: "こんにちは#{user.name}さん"
  end

  it "ログイン画面から不正メールアドレス・パスワードでログインし、メッセージが表示されている" do
    visit new_admin_session_path
    fill_in "Mail", with: "false_email@example.com"
    fill_in "Password", with: "falsepassword"
    click_on "ログイン"
    expect(page).to have_content "メールアドレスかパスワードが間違っています"
  end

  context "ログインが成功したとき" do
    before do
      visit new_admin_session_path
      fill_in "Mail", with: user.mail
      fill_in "Password", with: user.password
      click_on "ログイン"
    end

    it "ログアウトして、ログアウト状態の画面に遷移されている" do
      accept_confirm do
        click_link "管理者画面からログアウト"
      end
      assert_selector "h1", text: "みなさんこんにちは"
    end
  end
end