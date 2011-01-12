require "yaml"
require "logger"

# Change 'SinatraTemplate' to the name you set in app.rb
APPENV = SinatraTemplate::App.environment
APPDIR = SinatraTemplate::App.root
# Uncomment and edit "config/config.yml" if you have a need to set custom app config values.
# APP_CONFIG = File.open(File.join(APPDIR, "/config/config.yml")) { |file| YAML.load(file) }

def setup_logging
  enable(:logging)
  log = File.new(File.join(APPDIR, 'log', "#{APPENV}.log"), "a")
  $stdout.reopen(log)
  $stderr.reopen(log)
end

configure(:production) do
  enable(:clean_trace)
  disable(:dump_errors)
end

configure(:development) do
  use Rack::Lint
  disable(:clean_trace)
end

configure do
  disable :run
  setup_logging
end