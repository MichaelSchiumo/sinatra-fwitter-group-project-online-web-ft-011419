
class TweetsController < ApplicationController

  enable :method_override


  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all

      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(params)

    if @tweet.content = ""
      redirect to '/tweets/new'
    elsif @tweet.save
      @user = current_user(session)
      @user.tweets << @tweet
      redirect to '/tweets'
    else
      redirect to '/signup'  
    end
  end


end
