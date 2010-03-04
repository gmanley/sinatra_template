require 'rubygems'
require 'application'
root_dir = File.dirname(__FILE__)

set :root,  root_dir
set :app_file, File.join(root_dir, 'application.rb')
disable :run

use Rack::Reloader

FileUtils.mkdir_p File.join(root_dir, 'log') unless File.exists?('log')
log = File.new(File.join(root_dir, 'log', "#{Sinatra::Application.environment}.log"), "a")
$stdout.reopen(log)
$stderr.reopen(log)

run Sinatra::Application