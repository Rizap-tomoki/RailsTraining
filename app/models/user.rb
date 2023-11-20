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
    enum sex: { male: '男性', female: '女性', other: 'その他', no_answer: '回答なし' }
    #都道府県enum使用
    enum address1: {
        1 => "北海道", 2 => "青森県", 3 => "岩手県", 4 => "宮城県", 5 => "秋田県",
        6 => "山形県", 7 => "福島県", 8 => "東京都", 9 => "神奈川県", 10 => "千葉県",
        11 => "埼玉県", 12 => "茨城県", 13 => "栃木県", 14 => "群馬県", 15 => "新潟県",
        16 => "富山県", 17 => "石川県", 18 => "福井県", 19 => "山梨県", 20 => "長野県",
        21 => "岐阜県", 22 => "静岡県", 23 => "愛知県", 24 => "三重県", 25 => "滋賀県",
        26 => "京都府", 27 => "大阪府", 28 => "兵庫県", 29 => "奈良県", 30 => "和歌山県",
        31 => "鳥取県", 32 => "島根県", 33 => "岡山県", 34 => "広島県", 35 => "山口県",
        36 => "徳島県", 37 => "香川県", 38 => "愛媛県", 39 => "高知県", 40 => "福岡県",
        41 => "佐賀県", 42 => "長崎県", 43 => "熊本県", 44 => "大分県", 45 => "宮崎県",
        46 => "鹿児島県", 47 => "沖縄県"
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

