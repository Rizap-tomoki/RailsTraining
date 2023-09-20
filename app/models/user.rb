class GoodnessValidator < ActiveModel::Validator
    def validate(record)
      if record.first_name == "Evil"
        record.errors.add :base, "これは悪人だ"
      end
    end
end

class User < ApplicationRecord
    #性別のバリデーション
    enum seibetu: { male: '男', female: '女' }
    #空白の投稿をさせないバリデーション
    validates :name, :rubi, :seibetu, :denwa, :keitai,  :mairu, :yuubinbango, :jusho1, :jusho2, :jusho3, :jusho4, :jusho5, :tanjobi, presence: { message: "空白の入力は避けてください" }
    #カタカナ表記のバリデーション
    validates :rubi, format: { with: /\A[ァ-ヶー－]+\z/ ,message: "%{value}カタカナ表記にしてください"}
    #固定電話のバリデーション
    validates :denwa, format: { with: /\A\d{2,5}-\d{1,4}-\d{4}\z/, message: "は無効な形式です" }
    #携帯電話のバリデーション
    validates :keitai, format: { with: /\A\d{3}-\d{4}-\d{4}\z/, message: "は無効な形式です（例: 000-0000-0000）" }
    #携帯電話のバリデーション
    validates :yuubinbango, format: { with: /\A\d{3}-\d{4}\z/, message: "は無効な形式です（例: 000-0000-0000）" }
    #メールアドレスのバリデーション
    validates :mairu,  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "は無効な形式です" }
end

