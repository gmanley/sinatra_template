require File.expand_path(File.dirname(__FILE__) + '/../../spec/spec_helper')

ENV['RACK_ENV'] ||= 'test'
DirectSmile.set(:environment, :test)

require 'capybara/cucumber'
Capybara.app = DirectSmile

module MyWorld
#  Capybara.javascript_driver = :envjs
  def app
    @app ||= Rack::Builder.new do
      run DirectSmile
    end
  end
  include Rack::Test::Methods
end

World(MyWorld)
