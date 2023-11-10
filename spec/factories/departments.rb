FactoryBot.define do
  factory :department do
    sequence(:name) { |n| "テスト部署#{n}" }
  end
end
