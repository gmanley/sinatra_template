source :rubygems

gem 'sinatra', require: 'sinatra/base', git: 'git://github.com/sinatra/sinatra.git'

gem 'mongoid', '~> 2.4'
gem 'bson_ext'

gem 'haml'
gem 'rake'
gem 'rack-flash3', require: 'rack/flash'
gem 'rack-test', require: false
gem 'pry', git: 'git://github.com/pry/pry.git'

group :development do
  gem 'heroku'
  gem 'sinatra-contrib', git: 'git://github.com/gmanley/sinatra-contrib.git', require: 'sinatra/reloader'
  gem 'thin'
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
