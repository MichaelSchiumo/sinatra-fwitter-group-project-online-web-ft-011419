class Helpers

  def current_user(session)
    if session[:id] != nil
     User.find(session[:id])
    end
  end

  def logged_in?(session)
     session.has_key?(:id)
  end

  def current_tweet(id)
   Tweet.find(id)
  end
end
