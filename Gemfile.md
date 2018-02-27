source 'https://rubygems.org'

gem 'rake'
gem 'rubocop'

group :test, :development  do
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end
