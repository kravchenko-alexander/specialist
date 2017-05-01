class V1::API < Grape::API
  prefix 'api'

  include V1::Exceptions::Handler
  version 'v1', using: :path
  format :json

  helpers V1::Helpers::SessionsHelper

  mount V1::Registrations
  mount V1::Sessions
  mount V1::Test

  add_swagger_documentation(
    base_path: '/',
    api_version: 'v1',
    hide_documentation_path: true,
    hide_format: true,
    info: {
      title: 'API documentation'
    }
  )
end
