APP_ROOT = Pathname('../..').expand_path(__FILE__)
APP_ENV = ENV['RACK_ENV'] ||= 'development'

ENV['BUNDLE_GEMFILE'] = APP_ROOT.join('Gemfile').to_s
require 'bundler/setup'
Bundler.require(:default, APP_ENV)

require 'yaml'
require 'uri'
require 'date'

Dir[APP_ROOT.join('lib/**/*.rb')].each { |path| require path }
require APP_ROOT.join('app')