require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    @user = User.new(params)

     if @user.username == "" || @user.email == "" || @user.password == ""
      redirect to "/signup"
    elsif @user.save
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/login' do
    if logged_in?(session)
      current_user(session)
      redirect to "/tweets"
    else
      erb :'users/login'
    end
  end

  get '/logout' do
    if logged_in?(session)
      session.clear
    end
    redirect to "/login"
  end  

end
