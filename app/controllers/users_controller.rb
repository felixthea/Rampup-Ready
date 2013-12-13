class UsersController < ApplicationController
  def index
    @users = User.all
    render :new
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      log_user_in!(@user)
      redirect_to @user
    else
      flash.now[:errors] = [@user.errors.full_messages]
      @user = User.new
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end
  
  def bulk_new
    @subdivisions = Subdivision.all
    render :bulk_new
  end
  
  def bulk_add
    password = User.generate_random_password
    email = params[:user][:email]
    subdivision_id = params[:user][:subdivision_id]
    @user = User.new(email: email, password: password, subdivision_id: subdivision_id)
    if @user.save
      msg = NotificationMailer.admin_sign_up_user_email(@user, current_user, password)
      msg.deliver!
      flash[:notice] = ["User created."]
      redirect_to bulk_new_users_url
    else
      @subdivisions = Subdivision.all
      fail
      flash[:errors] ||= []
      flash[:errors] += @user.errors.full_messages
      render :bulk_new
    end
  end

end
