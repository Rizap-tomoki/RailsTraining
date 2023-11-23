FactoryBot.define do
    factory :user do
      name { "テストユーザー" }
      hiragana_nama { "テストユーザー" }
      sex { "男性" }
      tel { "123-4567-8901" }
      mobile { "987-6543-2109" }
      mail { "test@example.com" }
      postcode { "123-4567" }
      address1 { "宮城県" }
      address2 { "新しい市" }
      address3 { "新しい町" }
      address4 { "新しい住所" }
      address5 { "新しい番地" }
      birthday { "2000-01-01" }
      association :department, factory: :department
      # スキルをファクトリに渡すための一時的な属性を追加
      transient do
        skills_count { 1 } # 必要に応じて数を変更してください
      end
      # スキルの関連付けを処理するためのコールバックを作成
      after(:create) do |user, evaluator|
        create_list(:user_skill, evaluator.skills_count, user: user, skill: create(:skill))
      end

    end
  end