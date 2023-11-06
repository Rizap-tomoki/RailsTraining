class Department < ApplicationRecord
    has_many :users, dependent: :destroy
    #部署名enum使用
    #enum department_name: { プロダクト開発統括1部: 'プロダクト開発統括1部', プロダクト開発統括2部: 'プロダクト開発統括2部' }
    #所在地enum使用
    # enum location: { 東京: '東京', 新宿: '新宿'}
    #責任者enum使用
    # enum manager: { 佐藤: '佐藤', 梅田: '梅田', 大塚: '大塚'}
end
