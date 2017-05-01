class Provider < ApplicationRecord
  PROVIDERS_TYPES = Dir.entries('app/models/providers/')
                       .select { |f| f.include?('.rb') }
                       .map { |f| "Providers::#{f.split('.rb').join.capitalize}" }
                       .freeze

  belongs_to :user, inverse_of: :providers
  has_many :sessions, dependent: :destroy, inverse_of: :provider

  validates :type, presence: true, inclusion: { in: PROVIDERS_TYPES }
end
