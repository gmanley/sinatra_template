require 'ostruct'

module Sinatra
  module Settings
    ENVIRONMENTS = %w(development production test)

    def config
      @config ||= config_file(APP_ROOT.join('config/config.yml'))
    end

    private
    def config_file(file)
      obj = config_for_env(YAML.load_file(file)) || {}
      obj.each { |key, value| obj[key] = config_for_env(value) }
      OpenStruct.new(obj)
    end

    def config_for_env(hash)
      if hash.respond_to?(:keys) && hash.keys.any? { |key| ENVIRONMENTS.include?(key) }
        non_env_specific = hash.reject { |key, value| ENVIRONMENTS.include?(key) }
        hash = hash[APP_ENV].merge(non_env_specific)
      end

      hash
    end
  end

  module Setup
    extend Settings

    def self.registered(app)
      setup_airbrake(app) if config.airbrake_api_key.present?
      setup_database
      app.set(:config, config)
    end

    private
    def self.setup_database
      Mongoid.configure do |mongoid_config|
        if uri = (ENV['MONGOHQ_URL'] || ENV['MONGOLAB_URI']) # For heroku deploys
          conn = Mongo::Connection.from_uri(uri)
          mongoid_config.master = conn.db(URI.parse(uri).path.gsub(/^\//, ''))
        else
          mongoid_config.from_hash(config.database)
        end
      end
    end

    def self.setup_airbrake(app)
      app.enable :raise_errors
      app.use Airbrake::Rack
      Airbrake.configure do |airbrake_config|
        airbrake_config.api_key = config.airbrake_api_key
      end
    end
  end
end