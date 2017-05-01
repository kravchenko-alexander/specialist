source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bcrypt'
gem 'jbuilder', '~> 2.5'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.2'
gem 'rubocop'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

# Grape API
gem 'grape', '0.15.0'
gem 'grape-entity', '0.4.8'
gem 'grape-swagger', '0.10.4'
gem 'grape-swagger-rails', '0.3.0'
gem 'hashie-forbidden_attributes'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
