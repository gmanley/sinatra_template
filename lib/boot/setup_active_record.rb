module Boot
  module SetupActiveRecord

    def self.included(base)
      base.initializers << ->(app) { setup_active_record(app) }
    end

    private
    def self.setup_active_record(app)
      app.register Sinatra::ActiveRecordExtension
      app.set :database, app.config.database
    rescue StandardError => e
      puts "Warning: #{e}"
    end
  end
end
