class Base < Grape::API
  include Exceptions

  mount V1::API
  mount V2::API
end
