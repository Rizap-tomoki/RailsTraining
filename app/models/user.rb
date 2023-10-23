# encoding: UTF-8
class User < ApplicationRecord
    #性別enum使用
    enum sex: { 男性: '男性', 女性: '女性', その他: 'その他', 回答なし: '回答なし' }
    #都道府県enum使用
    enum address1: {
        "北海道": "北海道", "青森県": "青森県", "岩手県": "岩手県", "宮城県": "宮城県", "秋田県": "秋田県",
        "山形県": "山形県", "福島県": "福島県", "東京都": "東京都", "神奈川県": "神奈川県", "千葉県": "千葉県",
        "埼玉県": "埼玉県", "茨城県": "茨城県", "栃木県": "栃木県", "群馬県": "群馬県", "新潟県": "新潟県",
        "富山県": "富山県", "石川県": "石川県", "福井県": "福井県", "山梨県": "山梨県", "長野県": "長野県",
        "岐阜県": "岐阜県", "静岡県": "静岡県", "愛知県": "愛知県", "三重県": "三重県", "滋賀県": "滋賀県",
        "京都府": "京都府", "大阪府": "大阪府", "兵庫県": "兵庫県", "奈良県": "奈良県", "和歌山県": "和歌山県",
        "鳥取県": "鳥取県", "島根県": "島根県", "岡山県": "岡山県", "広島県": "広島県", "山口県": "山口県",
        "徳島県": "徳島県", "香川県": "香川県", "愛媛県": "愛媛県", "高知県": "高知県", "福岡県": "福岡県",
        "佐賀県": "佐賀県", "長崎県": "長崎県", "熊本県": "熊本県", "大分県": "大分県", "宮崎県": "宮崎県",
        "鹿児島県": "鹿児島県", "沖縄県": "沖縄県"
      }
    #空白の投稿をさせないバリデーション
    validates :name, :hiragana_nama, :sex, :tel, :mobile,  :mail, :postcode, :address1, :address2, :address3, :address4, :birthday, presence: { message: "空白の入力は避けてください" }
    #重複の投稿をさせないバリデーション
    validates :mobile, :mail, :tel, uniqueness: { message: "既存のデータがあります" }
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
    #誕生日のバリデーション
    validate :under_age_18
    def under_age_18
        if birthday.present? && birthday > 18.years.ago.to_date
        errors.add(:birthday, "は18歳以上である必要があります")
        end
    end
end

