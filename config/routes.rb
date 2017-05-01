Rails.application.routes.draw do
  mount Base => '/'
  mount GrapeSwaggerRails::Engine => '/api/swagger'
end
