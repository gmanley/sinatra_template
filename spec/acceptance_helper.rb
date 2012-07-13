require 'spec_helper'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.configure do |config|
  config.save_and_open_page_path = APP_ROOT.join('tmp/capybara')
  config.app = App
  config.asset_root = APP_ROOT.join('public')
end