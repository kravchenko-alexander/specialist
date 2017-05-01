class Session < ApplicationRecord
  enum device_kind: {
    android: 0, ios: 1, web: 2
  }

  belongs_to :provider, inverse_of: :sessions
  belongs_to :user, inverse_of: :sessions

  validates :device_kind, presence: true, inclusion: { in: Session.device_kinds.flatten }
  validates :access_token, :refresh_token, presence: true, uniqueness: { scope: :user }
  validates :push_token, uniqueness: { allow_nil: true, scope: :device_kind }
  validates :access_token_expiration, :refresh_token_expiration, presence: true

  before_validation :set_access_token, :set_refresh_token, on: :create
  before_validation :set_access_token_expiration, :set_refresh_token_expiration, on: :create
  before_validation :destroy_extra_push_tokens, on: :create, unless: proc { |user| user.push_token.nil? }

  scope :active, (-> { where('access_token_expiration >= ', Time.zone.now) })
  scope :refresh_active, (-> { where('refresh_token_expiration >= ', Time.zone.now) })
  scope :with_push_token, (-> { where.not(push_token: nil) })

  def device_kind=(val)
    super val
  rescue
    nil
  end

  def refresh!
    set_access_token
    set_refresh_token
    set_access_token_expiration
    set_refresh_token_expiration
  end

  private

  def set_access_token
    self.access_token = loop do
      random_token = SecureRandom.urlsafe_base64(64, false)
      break random_token unless Session.exists?(access_token: random_token)
    end
  end

  def set_refresh_token
    self.refresh_token = loop do
      random_token = SecureRandom.urlsafe_base64(64, false)
      break random_token unless Session.exists?(refresh_token: random_token)
    end
  end

  def set_access_token_expiration
    self.access_token_expiration = Time.zone.now + Rails.application.config.session_expiration
  end

  def set_refresh_token_expiration
    self.refresh_token_expiration = Time.zone.now + Rails.application.config.session_refresh_expiration
  end

  def destroy_extra_push_tokens
    Session.where(device_kind: device_kind, push_token: push_token).destroy_all
  end
end
