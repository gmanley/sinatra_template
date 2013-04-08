source 'https://rubygems.org'

gem 'sinatra', github: 'sinatra/sinatra', require: 'sinatra/base'

gem 'mongoid'
gem 'bson_ext'

gem 'haml'
gem 'rack-flash3', require: 'rack/flash'
gem 'rack-test', require: false
gem 'pry'
gem 'thin'

group :development do
  gem 'heroku'
  gem 'sinatra-contrib', github: 'sinatra/sinatra-contrib', require: 'sinatra/reloader'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec'
  gem 'capybara', require: 'capybara/dsl'
  gem 'launchy'
end

group :development, :test do
  gem 'faker'
  gem 'fabrication'
end
