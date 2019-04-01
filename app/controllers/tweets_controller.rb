
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
end
