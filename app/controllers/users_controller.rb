class UsersController < ApplicationController

  before_filter :require_current_user!, except: [:new, :create, :forgot_password,
    :send_forgot_password_email, :set_new_password, :update_password]
  before_filter :require_admin!, only: [:bulk_add, :bulk_new]
  def index
    @users = User.all
    render :new
  end

  def new
    @user = User.new
    @subdivisions = Subdivision.all
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      log_user_in!(@user)
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

  def add_more
    @subdivisions = Subdivision.all
    render partial: 'users/bulk_form', locals: { subdivisions: @subdivisions }
  end

  def bulk_add
    new_users = []
    password = User.generate_random_password

    params[:users][:email].length.times do |i|
      new_users << User.new(email: params[:users][:email][i], password: password, subdivision_id: params[:users][:subdivision_id][i])
    end

    begin
      ActiveRecord::Base.transaction do
        new_users.each(&:save)

        unless new_users.all?(&:persisted?)
          raise 'Users not created.'
        end
      end
    rescue Exception => e
      render json: e.message
    else
      render json: "Users were saved."
    end
  end

  def favorites
    @definition_faves = DefinitionFave.find_all_by_user_id(current_user.id)
    @curriculum_faves = CurriculumFave.find_all_by_user_id(current_user.id)
    render 'favorites/index'
  end

  def forgot_password
    render :forgot_password
  end

  def send_forgot_password_email
    user = User.find_by_email(params[:email])
    user.set_forgot_pw_token!
    msg = AuthMailer.forgot_password_email(user)
    msg.deliver!
    flash[:notice] = ["Check your email for instructions on resetting your password."]
    redirect_to new_session_url
  end

  def set_new_password
    token = params[:token]
    user = User.find_by_forgot_password_token(token)
    if token == nil || user.nil?
      flash[:errors] = ["You are not authorized to visit that page."]
      redirect_to :root
    else
      @user = user
      render :set_new_password
    end
  end

  def update_password
    @user = User.find_by_forgot_password_token(params[:token])
    new_password = params[:new_password]
    @user.update_attributes(password: new_password, forgot_password_token: nil)
    if @user.save
      flash[:notice] = ["Your password has been updated and you've been logged in!"]
      log_user_in!(@user)
    else
      flash[:errors] ||= []
      flash[:errors] += @user.errors.full_messages
      render :set_new_password
    end
  end

end
