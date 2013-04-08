module Boot
  module SetupAirbrake

    def self.included(base)
      base.initializers << ->(app) { setup_airbrake(app) }
    end

    private
    def self.setup_airbrake(app)
      if app.config.airbrake_api_key.present?
        app.enable :raise_errors
        app.use ::Airbrake::Rack
        ::Airbrake.configure do |airbrake_config|
          airbrake_config.api_key = app.config.airbrake_api_key
        end
      end
    end
  end
end
