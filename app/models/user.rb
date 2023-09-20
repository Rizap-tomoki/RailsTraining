class User < ApplicationRecord
    #性別のバリデーション
    enum sex: { 男性: '男性', 女性: '女性', その他: 'その他', 回答なし: '回答なし' }
    #空白の投稿をさせないバリデーション
    validates :name, :hiragana_nama, :sex, :tel, :mobile,  :mail, :postcode, :address1, :address2, :address3, :address4, :birthday, presence: { message: "空白の入力は避けてください" }
    #カタカナ表記のバリデーション
    validates :hiragana_nama, format: { with: /\A[ァ-ヶー－]+\z/ ,message: "%{value}カタカナ表記にしてください"}
    #固定電話のバリデーション
    validates :tel, format: { with: /\A\d{2,5}-\d{1,4}-\d{4}\z/, message: "は無効な形式です" }
    #携帯電話のバリデーション
    validates :mobile, format: { with: /\A\d{3}-\d{4}-\d{4}\z/, message: "は無効な形式です（例: 000-0000-0000）" }
    #郵便電話のバリデーション
    validates :postcode, format: { with: /\A\d{3}-\d{4}\z/, message: "は無効な形式です（例: 000-0000-0000）" }
    #メールアドレスのバリデーション
    validates :mail,  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "は無効な形式です" }
end

