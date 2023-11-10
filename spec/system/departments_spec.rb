require "rails_helper"

RSpec.describe "departmentコントローラのシステムテスト", type: :system do
  let(:department) { FactoryBot.create(:department) }

  it "部署詳細画面の検出" do
    visit department_path(department)
    expect(page).to have_content('部署名:テスト部署')
  end

  it "部署投稿" do
    visit new_department_path
    all_text_fields = all('input[type="text"]')
    all_text_fields.each do |text_field|
      expect(text_field.value).to be_empty
    end
    fill_in "名前", with: "テスト部署"
    click_button "送信"
  end

  it "部署名情報を編集" do
    department_id = department.id
    visit edit_department_path(department_id)
    fill_in "名前", with: "テスト部署"
    click_button "送信"
  end

  it "部署情報の削除" do
    visit department_path(department)
    accept_confirm do
      click_link "Destroy"
    end
    expect(page).not_to have_content('テスト部署')
  end
  
  it "部署情報の削除をキャンセル" do
    visit department_path(department)
    dismiss_confirm do
      click_link "Destroy"
    end
    expect(page).to have_content('テスト部署')
  end

end
