ENV["RACK_ENV"] ||= "development"
ENV["CONFIG_RU"] ||= File.dirname(__FILE__) + '/../config.ru'

require "rubygems"
require "rack/test"

module RackIRB
  class Session
    include Rack::Test::Methods
    attr_reader :app

    def initialize(app)
      @app = app
    end

    def env; ENV['RACK_ENV']; end
  end

  def self.run!
    # prevent STDOUT & STDERR to be reopened (apps do this to be able to log under Passenger)
    def STDOUT.reopen(*args); end
    def STDERR.reopen(*args); end

    # build Rack app
    config_ru = ENV['CONFIG_RU']
    $rack_app = Object.class_eval("Rack::Builder.new { #{IO.read(config_ru)} }", config_ru)
    Object.class_eval {
      def app
        @app ||= RackIRB::Session.new($rack_app)
      end

      def sinatra
        Picawing
      end

      def reload!
        @reloader ||= Rack::Reloader.new(app)
        @reloader.reload!
        load('script/app_loader.rb')
      end

      def console_help
        help = <<-HELP
---
Methods:
  app             => RackIRB::Session, responds to all rack methods
                     (see rdoc of Rack::Test::Methods)
  sinatra         => Sinatra::Application, the actual application
  reload!         => Reload the Sinatra Application (only affects
                     files that have been touched)
  console_help    => This help message.
        HELP
        puts help
      end
    }

    # print startup info
    if STDOUT.tty? && ENV['TERM'] != 'dumb' # we have color terminal, let's pimp our info!
      env_color = (Object.app.env == 'production' ? "\e[31m\e[1m" : "\e[36m\e[1m")
      $stdout.puts "\e[32m\e[1mSinatra\e[0m\e[33m\e[1m::\e[0m\e[32m\e[1mIRB\e[0m started in #{env_color}#{Object.app.env}\e[0m environment."
      $stdout.puts "Enter #{env_color}console_help\e[0m to get available commands"
    else
      $stdout.puts "Sinatra::IRB started in #{Object.app.env} environment."
    end
  rescue Errno::ENOENT => e
    if e.message =~ /config\.ru$/
      $stdout.puts "I couldn't find #{config_ru}"
      exit(1)
    else
      raise e
    end
  end
end

RackIRB.run!