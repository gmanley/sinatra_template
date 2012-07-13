require 'bundler/setup'
require 'yaml'

$:.unshift('.').uniq!
ENV['RACK_ENV'] ||= 'development'

namespace :log do
  desc 'clear log files'
  task :clear do
    Dir['log/*.log'].each do |f|
      f = File.open(f, 'w')
      f.close
    end
  end
end

namespace :db do
  desc 'Load seed data'
  task :seed do
    load('db/seeds.rb')
  end
end

namespace :heroku do
  desc 'Deploy to heroku & set required config values from config/config.yml'
  task :deploy do
    config = YAML.load_file('config/config.yml')

    config_key_value_pairs = %w[heroku=true]
    config.each do |key, value|
      config_key_value_pairs << "#{key}='#{value}'" unless key == 'database'
    end

    system("heroku config:add #{config_key_value_pairs.join(' ')}")
    system('git push heroku master')
  end
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec