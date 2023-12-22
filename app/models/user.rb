# encoding: UTF-8
class User < ApplicationRecord
    belongs_to :department, optional: true
    has_and_belongs_to_many :skills
    # 正規表記のバリデーション
    validates :mail, regex_mail: true
    validates :mobile, regex_mobile: true
    validates :tel, regex_tel: true
    validates :postcode, regex_postcode: true
    validates :hiragana_nama, regex_hiragana: true

    #性別enum使用
    enum sex: { '男性': 'male', '女性': 'female', 'その他': 'other', '回答なし': 'no_answer' }
    #都道府県enum使用
    enum address1: {
    '北海道': 'hokkaido', '青森県': 'aomori', '岩手県': 'iwate', '宮城県': 'miyagi', '秋田県': 'akita',
    '山形県': 'yamagata', '福島県': 'fukushima', '東京都': 'tokyo', '神奈川県': 'kanagawa', '千葉県': 'chiba',
    '埼玉県': 'saitama', '茨城県': 'ibaraki', '栃木県': 'tochigi', '群馬県': 'gunma', '新潟県': 'niigata',
    '富山県': 'toyama', '石川県': 'ishikawa', '福井県': 'fukui', '山梨県': 'yamanashi', '長野県': 'nagano',
    '岐阜県': 'gifu', '静岡県': 'shizuoka', '愛知県': 'aichi', '三重県': 'mie', '滋賀県': 'shiga',
    '京都府': 'kyoto', '大阪府': 'osaka', '兵庫県': 'hyogo', '奈良県': 'nara', '和歌山県': 'wakayama',
    '鳥取県': 'tottori', '島根県': 'shimane', '岡山県': 'okayama', '広島県': 'hiroshima', '山口県': 'yamaguchi',
    '徳島県': 'tokushima', '香川県': 'kagawa', '愛媛県': 'ehime', '高知県': 'kochi', '福岡県': 'fukuoka',
    '佐賀県': 'saga', '長崎県': 'nagasaki', '熊本県': 'kumamoto', '大分県': 'oita', '宮崎県': 'miyazaki',
    '鹿児島県': 'kagoshima', '沖縄県': 'okinawa'
  }

    # 空白の投稿をさせないバリデーション
    validates :name, :hiragana_nama, :sex, :tel, :mail, :postcode, :address1, :address2, :address3, :address4, :birthday, presence: { message: "空白の入力は避けてください" }
    # 重複の投稿をさせないバリデーション
    validates :mail, :tel, uniqueness: { message: "既存のデータがあります" }
    # 誕生日が未来の日付でないことの確認
    validates :birthday, past_date: true
    # 誕生日のバリデーション
    validates :birthday, over_age_18: true
 
end

