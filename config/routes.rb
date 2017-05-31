Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  mount Base => '/'
  mount GrapeSwaggerRails::Engine => '/api/swagger'
end
