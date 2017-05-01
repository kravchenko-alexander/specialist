class V2::API < Grape::API
  version 'v2', using: :path
  format :json

  add_swagger_documentation(
    base_path: '/api',
    api_version: 'v2',
    hide_documentation_path: true,
    hide_format: true,
    info: {
      title: 'API documentation'
    }
  )
end
