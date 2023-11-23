require "rails_helper"

RSpec.describe "skillコントローラのシステムテスト", type: :system do
  let(:skill) { FactoryBot.create(:skill) }

  it "スキル詳細画面の検出" do
    visit skill_path(skill)
    expect(page).to have_content('スキル名:新しいスキル')
  end

  it "スキルページでスキル名を入力し、正しいレンダリングがしている" do
    visit new_skill_path
    text_field = find('input[type="text"]')
    expect(text_field.value).to be_empty
    fill_in "名前", with: "新しいスキル"
    click_button "送信"
    expect(page).to have_content('スキル名:新しいスキル')
  end


  it "スキル名情報を編集し、正しいレンダリングがされている" do
    visit edit_skill_path(skill.id)
    fill_in "名前", with: "新しいスキル"
    click_button "送信"
    expect(page).to have_content('新しいスキル')
  end

  it "スキル情報の削除し、既存のスキル名がレンダリングされていない" do
    visit skill_path(skill)
    accept_confirm do
      click_link "Destroy"
    end
    expect(page).not_to have_content('新しいスキル')
  end
  
  it "スキル情報の削除をキャンセルし、既存のスキル名がレンダリングされている" do
    visit skill_path(skill)
    dismiss_confirm do
      click_link "Destroy"
    end
    expect(page).to have_content('新しいスキル')
  end

end
