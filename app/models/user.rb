class User < ApplicationRecord
  module Gender
    extend ActiveSupport::Concern

    included do
      enum gender: {
        male: 0, female: 1
      }

      validate :validate_gender
    end

    def gender=(val)
      super val
    rescue
      @__bad_gender_value = val
      nil
    end

    private

    def validate_gender
      errors.add(:gender, 'is not valid') if @__bad_gender_value
    end
  end

  module Email
    extend ActiveSupport::Concern

    VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    included do
      validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, presence: true
    end
  end

  module SecretToken
    extend ActiveSupport::Concern

    included do
      validates :secret_token, presence: true

      before_validation :set_secret_token, on: :create
    end

    private

    def set_secret_token
      self.secret_token = SecureRandom.urlsafe_base64(64, false)
    end
  end

  include Email
  include Gender
  include SecretToken

  has_secure_password

  has_many :providers, dependent: :destroy, inverse_of: :user
  has_many :sessions,  dependent: :destroy, inverse_of: :user

  validates :password_confirmation, presence: true
end
