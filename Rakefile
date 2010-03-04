require 'rubygems'
require "rake"
require "rake/clean"
require 'dm-core'
require 'sinatra'

task :default  => :spec

require Pathname(Sinatra::Application.root)/"models"/"user"

namespace :log do
  desc "clear log files"
  task :clear do
    Dir.glob(File.join(File.dirname(__FILE__), 'log', '*.log')){ |file| File.open(file, "w") { |file| file << "" }}
  end
end

namespace :db do
  require 'config/database'

  desc "Migrate the database"
  task :migrate do
    User.auto_migrate!
  end

  desc "Add new users"
  task :add_users do
    #Example
    as = User.new
    as.login = "user"
    as.password = "password"
    as.save
  end
end


