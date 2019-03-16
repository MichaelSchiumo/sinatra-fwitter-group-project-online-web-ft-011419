require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    "Welcome to Fwitter!"
  end

  get '/signup' do
    erb :'signup'
  end

  post '/signup' do
    @user = User.create(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id
    puts params

    redirect to '/twitter_index'
  end

  get '/login' do

  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end  
end
