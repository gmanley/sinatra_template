require "rubygems"
require "rspec"
require "rack/test"
require "sinatra"

include Rack::Test::Methods

set :views => File.join(File.dirname(__FILE__), "..", "views"),
    :public => File.join(File.dirname(__FILE__), "..", "public")

set :environment, :test
set :reload_templates, true

require File.join(File.dirname(__FILE__), "..", "init")

module TestHelper
  def app
    App.new
  end

  def body
    last_response.body
  end

  def status
    last_response.status
  end

  include Rack::Test::Methods

end