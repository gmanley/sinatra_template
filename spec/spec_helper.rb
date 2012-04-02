APP_ROOT = File.expand_path('../..', __FILE__)
ENV['RACK_ENV'] = 'test'

require 'rack/test'
require File.join(APP_ROOT, 'lib/boot')
def app; App end

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = 'mongoid'
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
