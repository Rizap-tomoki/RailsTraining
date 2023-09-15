require "rails_helper"
RSpec.describe "全体のテスト名", type: :system do
 it "テスト名" do
     visit root_path
     expect(page).to have_content "indexファイルのh1タグの内容"
 end
end
