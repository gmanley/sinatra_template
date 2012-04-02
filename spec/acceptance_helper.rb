require 'spec_helper'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.configure do |config|
  config.save_and_open_page_path = File.join(APP_ROOT, 'tmp/capybara')
  config.app = App
  config.asset_root = Pathname(File.join(APP_ROOT, 'public'))
end