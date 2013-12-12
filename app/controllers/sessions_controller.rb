class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email],
            params[:user][:password])

    if user.nil?
      flash.now[:errors] = ["Invalid username or password."]
      render :new
    else
      log_user_in!(user)
    end
  end

  def destroy
    log_user_out!
    render :new
  end
end
