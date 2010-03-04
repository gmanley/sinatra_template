####
# Resources
# => Datamapper:  http://rdoc.info/projects/datamapper/dm-core
# => Sinatra: http://www.sinatrarb.com/documentation.html
# --------------------------
# 
####
# require gem libraries here
%w[
  rubygems
  sinatra
  haml
  dm-core
  dm-types
  dm-validations
  dm-timestamps
  dm-migrations
  dm-adjust
  dm-aggregates
  yaml
  pathname
  logger
  ].each do |lib|
  begin
    require lib
  rescue LoadError => e
    puts "You need to install the #{lib} gem."
    exit(1)
  end
end

# Plugins
#---------------------------

# Utility Stuff and Configuration
#---------------------------
unless defined?(APPDIR)
  APPDIR = Pathname(Sinatra::Application.root)
end

def setup_db(env)
  # leave this out of configure blocks because of load order issue 
  config = File.open(APPDIR/"config"/"database.yml") { |file| YAML.load(file) }
  DataMapper::Logger.new(APPDIR/"log"/"#{env}_db.log")
  DataMapper.setup(:default, config[env.to_s])
end

configure(:production) do
  enable(:clean_trace)
  disable(:dump_errors)
  setup_db(:production)
end

configure(:development) do
  use Rack::Lint
  disable(:clean_trace)
  setup_db(:development)
end

configure(:test) do
  disable(:logging)
  setup_db(:test)
end

configure do
  enable(:sessions, :logging)
end

# Application Requirements
#---------------------------
app_load_paths = %w(lib models)
app_load_paths.each{ |path| Dir[APPDIR/"#{path}"/'**'/'*.rb'].sort.each{|file|
  require file
}}

# Helpers: modules are in the lib dir
#---------------------------
helpers(ApplicationHelper)

# Filters
#---------------------------
before do
end

# Routes
#---------------------------

get '/' do

end


get '/redirect' do
  redirect params[:to] and return
end

# Authentication
#---------------------------

get '/user/login' do
  erb :'/user/login'
end

post '/user/login' do
  if user = User.authenticate(params[:login], params[:password])
    session[:user] = user.id
    flash("Login successful")
    redirect '/'
  else
    flash("Login failed - Try again")
    erb :'/user/login'
  end
end

get '/logout' do
  session[:user] = nil
  flash("Logout successful")
  redirect '/'
end