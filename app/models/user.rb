class User < ApplicationRecord
    validates :name, presence: true
    validates :name, presence: true, length: { minimum: 3 }
end
