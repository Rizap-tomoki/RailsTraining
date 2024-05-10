require 'bcrypt'

module CustomPasswordSecure
  extend ActiveSupport::Concern

  included do
    attr_accessor :password
    before_save :encrypt_password
    validate :password_presence
    validates_confirmation_of :password, allow_blank: true
  end

  def encrypt_password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end
end
