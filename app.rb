module SinatraTemplate # Change this to your app name
  class App < Sinatra::Base

    # Set the sinatra app main directory to where this file is.
    set :root, File.dirname(__FILE__)
    # Using an init file for configuration to keep app file clean.
    require "lib/init"

    get '/' do
      # I like haml but you can change this to almost any templating language.
      # Just add a require and add it to the gemfile if it's a gem
      haml :index, :format => :html5
    end
  end
end