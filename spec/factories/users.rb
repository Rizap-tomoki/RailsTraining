FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    hiragana_nama { "テストユーザー" }
    sex { "男性" }
    tel { "123-4567-8901" }
    mobile { "987-6543-2109" }
    mail { "test@example.com" }
    password { "password" }
    postcode { "123-4567" }
    address1 { "宮城県" }
    address2 { "新しい市" }
    address3 { "新しい町" }
    address4 { "新しい住所" }
    address5 { "新しい番地" }
    birthday { "2000-01-01" }
    association :department, factory: :department
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'image', 'test_image.jpg')) }
  end
end