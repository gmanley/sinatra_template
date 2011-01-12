require "rubygems"
# Requiring sinatra/base gives us more
# flexibility and makes it easier to use this app in others
# (see http://www.sinatrarb.com/extensions.html)
require "sinatra/base"

# Setup bundler to be used in the app.
require "bundler/setup"
# Require all the enviroment in-specific gems and
# the gems for your current enviroment.
Bundler.require(:default, ENV["RACK_ENV"])

require "app"
# Change 'SinatraTemplate' to the name you set in app.rb
run SinatraTemplate::App