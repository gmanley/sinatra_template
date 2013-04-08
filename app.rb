class App < Sinatra::Base
  register Boot

  get '/' do
    haml :index
  end

  post '/user/login' do
    if user = User.authenticate(params[:email], params[:password])
      flash[:notice] = 'Logged in successfully'
      session[:user_id] = user.id.to_s
      redirect '/'
    else
      flash[:notice] = 'Incorrect credentials'
      redirect '/'
    end
  end

  get '/user/new' do
    haml :register
  end

  post '/user/new' do
    @user = User.create(params)
    if @user.valid?
      flash[:notice] = 'Registered successfully!'
      session[:user_id] = @user.id.to_s
      redirect '/'
    else
      haml :register
    end
  end

  get '/user/logout' do
    session[:user_id] = nil
    redirect '/'
  end
end
