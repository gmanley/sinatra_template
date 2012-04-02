ENV["RACK_ENV"] ||= "development"
ENV["CONFIG_RU"] ||= File.expand_path('../../config.ru', __FILE__)

require 'rack/test'

module RackIRB
  class Session
    include Rack::Test::Methods
    attr_reader :session

    def initialize(session)
      @session = session
    end

    def env; ENV['RACK_ENV']; end
  end

  def self.run!
    # build Rack app
    config_ru = ENV['CONFIG_RU']
    $rack_app = Object.class_eval("Rack::Builder.new { #{File.read(config_ru)} }", config_ru)

    Object.class_eval do
      def session
        @session ||= RackIRB::Session.new($rack_app)
      end

      def app
        $rack_app.to_app
      end

      def reload!
        @reloader ||= Rack::Reloader.new(app)
        @reloader.reload!
        load(File.expand_path(__FILE__))
      end

      def console_help
        help = <<-HELP
---
Methods:
  session         => RackIRB::Session, responds to all rack methods
                     (see rdoc of Rack::Test::Methods)
  app             => Sinatra::Application, the actual application
  reload!         => Reload the Sinatra Application (only affects
                     files that have been touched)
  console_help    => This help message.
        HELP
        puts help
      end
    end

    # print startup info
    if STDOUT.tty? && ENV['TERM'] != 'dumb' # we have color terminal, let's pimp our info!
      env_color = (Object.session.env == 'production' ? "\e[31m\e[1m" : "\e[36m\e[1m")
      $stdout.puts "\e[32m\e[1mSinatra\e[0m\e[33m\e[1m::\e[0m\e[32m\e[1mIRB\e[0m started in #{env_color}#{Object.session.env}\e[0m environment."
      $stdout.puts "Enter #{env_color}console_help\e[0m to get available commands"
    else
      $stdout.puts "Sinatra::IRB started in #{Object.session.env} environment."
    end
  end
end

RackIRB.run!
pry
