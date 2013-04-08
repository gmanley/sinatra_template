require 'pathname'

APP_ROOT = Pathname('../..').expand_path(__FILE__)
APP_ENV = ENV['RACK_ENV'] ||= 'development'

ENV['BUNDLE_GEMFILE'] ||= APP_ROOT.join('Gemfile').to_s
require 'bundler/setup'
Bundler.require(:default, APP_ENV)

Dir[APP_ROOT.join('lib/**/*.rb')].each {|f| require f }

module Boot
  extend Sinatra::Config

  def self.initializers
    @initializers ||= []
  end

  def self.registered(app)
    app.set :root, APP_ROOT
    app.set :config, config_file(APP_ROOT.join('config/config.yml'), APP_ENV)

    app.enable :sessions
    app.set :session_secret, app.config.session_secret

    app.set :haml, { format: :html5 }

    app.use Rack::Flash, sweep: true

    app.helpers ApplicationHelper

    app.configure(:development) do
      app.register Sinatra::Reloader
      app.also_reload 'lib/**/*.rb'
    end

    initializers.each { |initializer| initializer.call(app) }
  end

  include SetupActiveRecord
  include SetupAirbrake
end

require APP_ROOT.join('app')
