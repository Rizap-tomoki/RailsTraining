require "rails_helper"
RSpec.describe "全体のテスト名", type: :system do
 it "rootパスでh1タグのUserを検出" do
     visit root_path
     expect(page).to have_content "Users"
 end
end
