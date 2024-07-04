require "rails_helper"

RSpec.describe "departmentのシステムテスト", type: :system do
  let(:department) { FactoryBot.create(:department) }

  it "部署詳細画面の検出" do
    visit department_path(department)
    expect(page).to have_content('部署名:新しい部署')
  end

  it "投稿ページで部署名を入力できる" do
    visit new_department_path
    text_field = find('input[type="text"]')
    expect(text_field.value).to be_empty
    fill_in "名前", with: "テスト部署"
    click_button "送信"
  end

  it "入力したデータが表示されている" do
    visit departments_path
    expect(page).to have_content('部署名:テスト部署')
  end

  it "部署名情報を編集し、編集されたデータが表示されている" do
    visit edit_department_path(department.id)
    fill_in "名前", with: "テスト部署"
    click_button "送信"
    expect(page).to have_content('テスト部署')
  end

  it "部署情報の削除し、既存のデータが表示されていない" do
    visit department_path(department)
    accept_confirm do
      click_link "Destroy"
    end
    expect(page).not_to have_content('新しい部署')
  end
  
  it "部署情報の削除をキャンセルし、既存のデータが表示されている" do
    visit department_path(department)
    dismiss_confirm do
      click_link "Destroy"
    end
    expect(page).to have_content('新しい部署')
  end

end
