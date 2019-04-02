require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'session secret'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :signup
    end
    #place in user controller
  end

  post '/signup' do
    @user = User.new(params)

    if @user.save
      session[:id] = @user.id
      redirect to "/tweets"
    else
        redirect to "/signup"
    end
  end

  get '/login' do
    if logged_in?
      current_user
      redirect to "/tweets"
    else
      erb :'users/login'
    end
  end

  post '/login' do

    @user = User.find_by(:username => params[:username])
    #binding.pry
     if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect to "/login"
  end

  helpers do
    def logged_in?
       session.has_key?(:id)
    end

    def current_user
      if session[:id] != nil
       User.find(session[:id])
      end
    end
  end
end
