# encoding: UTF-8
class User < ApplicationRecord
    belongs_to :department
    # 正規表記のバリデーション
    validates :mail, regex_mail: true
    validates :mobile, regex_mobile: true
    validates :tel, regex_tel: true
    validates :postcode, regex_postcode: true
    validates :hiragana_nama, regex_hiragana: true

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

    # #空白の投稿をさせないバリデーション
    validates :name, :hiragana_nama, :sex, :tel, :mobile,  :mail, :postcode, :address1, :address2, :address3, :address4, :birthday, :department_id,  presence: { message: "空白の入力は避けてください" }
    # #重複の投稿をさせないバリデーション
    validates :mobile, :mail, :tel, uniqueness: { message: "既存のデータがあります" }
    
    #誕生日のバリデーション
    validates :birthday, over_age_18: true
    #誕生日が未来の日付でないことの確認
    validates :birthday, past_date: true

end

