module SessionsHelper
  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def log_user_in!(user)
    session[:session_token] = user.reset_session_token!
    redirect_to :root
  end

  def log_user_out!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def user_logged_in
    !!current_user
  end

  def require_current_user!
    if user_logged_in == false
      flash[:errors] = ["You must be logged in."]
      redirect_to new_session_url
    end
  end

  def require_admin!
    if current_user.admin == false || user_logged_in == false
      flash[:errors] = ["You must be an admin."]
      redirect_to :root
    end
  end

  def require_author!
    if current_user.id != Definition.find(params[:id])
      flash[:errors] = ["You must be the author."]
      redirect_to new_session_url
    end
  end

  def require_curriculum_creator_or_admin!
    unless (current_user.id == Curriculum.find(params[:id]).user_id || current_user.admin == true)
      flash[:errors] = ["You must be the curriculum creator or admin."]
      redirect_to new_session_url
    end
  end

  def require_author_or_admin!
    unless (current_user.id == Definition.find(params[:id]).user_id || current_user.admin == true)
      flash[:errors] = ["You must be the author or admin."]
      redirect_to new_session_url
    end
  end
  
  def is_current_user?(user_id)
    user_id == current_user.id
  end
end
