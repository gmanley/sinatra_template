module Boot
  module SetupMongoid

    def self.included(base)
      base.initializers << ->(app) { setup_mongoid(app) }
    end

    private
    def self.setup_mongoid(app)
      Mongoid.configure do |mongoid_config|
        if uri = (ENV['MONGOHQ_URL'] || ENV['MONGOLAB_URI']) # For heroku deploys
          conn = Mongo::Connection.from_uri(uri)
          mongoid_config.master = conn.db(URI.parse(uri).path.gsub(/^\//, ''))
        else
          mongoid_config.load_configuration(app.config.database)
        end
      end
    end
  end
end
