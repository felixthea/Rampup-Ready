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
      flash.now[:errors] = @user.errors.full_messages
      @user = User.new
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

end
