require 'ostruct'
require 'yaml'

module Sinatra::Config
  ENVIRONMENTS = %w(development production test)

  private
  def config_file(file, env)
    obj = config_for_env(YAML.load_file(file), env) || {}
    obj.each { |key, value| obj[key] = config_for_env(value, env) }
    OpenStruct.new(obj)
  end

  def config_for_env(hash, env)
    if hash.is_a?(Hash) && hash.keys.any? { |key| ENVIRONMENTS.include?(key) }
      non_env_specific = hash.reject { |key, value| ENVIRONMENTS.include?(key) }
      hash = hash[env].merge(non_env_specific)
    end

    hash
  end
end
