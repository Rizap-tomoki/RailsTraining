require "rails_helper"

RSpec.describe "skillのシステムテスト", type: :system do
  let(:skill) { FactoryBot.create(:skill) }

  it "スキル詳細画面の検出" do
    visit skill_path(skill)
    expect(page).to have_content('スキル名:新しいスキル')
  end

  it "スキル名入力フィールドが空である" do
    visit new_skill_path
    text_field = find('input[type="text"]')
    expect(text_field.value).to be_empty
  end

  it "スキル名を入力し、送信後に入力されたデータが表示される" do
    visit new_skill_path
    fill_in "名前", with: "新しいスキル"
    click_button "送信"
    expect(page).to have_content('スキル名:新しいスキル')
  end


  it "スキル名情報を編集し、編集されたデータが表示されている" do
    visit edit_skill_path(skill.id)
    fill_in "名前", with: "新しいスキル"
    click_button "送信"
    expect(page).to have_content('新しいスキル')
  end

  it "スキル情報の削除し、既存のスキル名が表示されていない" do
    visit skill_path(skill)
    accept_confirm do
      click_link "Destroy"
    end
    expect(page).not_to have_content('新しいスキル')
  end
  
  it "スキル情報の削除をキャンセルし、既存のスキル名が表示されている" do
    visit skill_path(skill)
    dismiss_confirm do
      click_link "Destroy"
    end
    expect(page).to have_content('新しいスキル')
  end

end
