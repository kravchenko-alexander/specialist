ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'spec_helper'
require 'rails/all'
require 'rspec/rails'
require 'tilt/template'
require 'database_cleaner'
require 'shoulda/matchers'
# require 'cancan/matchers'
require 'support/api_helpers'

abort('The Rails env is running in production mode!') if Rails.env.production?
ActiveRecord::Migration.maintain_test_schema!
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Shoulda::Callback::Matchers::ActiveModel
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.filter_rails_from_backtrace!
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
  config.include ApiHelpers
  config.before(:each) do
    DatabaseCleaner.clean
    DatabaseCleaner.start
    load Rails.root + 'db/seeds.rb'
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
