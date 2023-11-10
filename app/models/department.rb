class Department < ApplicationRecord
    has_many :users, dependent: :nullify
    #空白の投稿をさせないバリデーション
    validates :name, presence: { message: "空白の入力は避けてください" }
    #重複の投稿をさせないバリデーション
    validates :name, uniqueness: { message: "既存のデータがあります" }
end
