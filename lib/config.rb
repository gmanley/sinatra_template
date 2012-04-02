require 'ostruct'

module Settings
  ENVIRONMENTS = %w(development production test)

  def config
    @config ||= config_file(File.join(APP_ROOT, 'config/config.yml'))
  end

  def setup_airbrake
    enable :raise_errors
    use Airbrake::Rack
    Airbrake.configure do |airbrake_config|
      airbrake_config.api_key = config.airbrake_api_key
    end
  end

  def setup_database
    Mongoid.configure do |mongoid_config|
      if ENV['MONGOHQ_URL'] # For heroku deploys
        conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
        mongoid_config.master = conn.db(URI.parse(ENV['MONGOHQ_URL']).path.gsub(/^\//, ''))
      else
        mongoid_config.from_hash(config.database)
      end
    end
  end

  private
  def config_file(file)
    obj = config_for_env(YAML.load_file(file)) || {}
    obj.each { |key, value| obj[key] = config_for_env(value) }
    OpenStruct.new(obj)
  end

  def config_for_env(hash)
    if hash.respond_to? :keys and hash.keys.any? {|k| ENVIRONMENTS.include?(k)}
      non_env_specific = hash.reject {|k,v| ENVIRONMENTS.include?(k)}
      hash = hash[APP_ENV].merge(non_env_specific)
    end

    hash
  end
end