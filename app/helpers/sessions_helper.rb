module SessionsHelper
  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def log_user_in!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_user_out!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def user_logged_in
    !!current_user
  end

  def require_current_user!
    redirect_to new_session_url if user_logged_in == false
  end

end
