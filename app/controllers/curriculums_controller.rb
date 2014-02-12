class CurriculumsController < ApplicationController

  before_filter :require_current_user!
  before_filter :require_curriculum_creator_or_admin!, only: [:edit, :update, :destroy]

  def index
    @my_curriculums = Curriculum.find_all_by_user_id(current_user.id)
    @public_curriculums = Curriculum.find_all_by_make_private(false)
    @public_curriculums.reject! { |public_curriculum| @my_curriculums.include?(public_curriculum) } 
    render :index
  end

  def show
    @curriculum = Curriculum.find(params[:id])
    render :show
  end

  def new
    @curriculum = Curriculum.new
    @definitions = Definition.all
    render :new
  end

  def create
    params[:curriculum][:user_id] = current_user.id
    @curriculum = Curriculum.new(params[:curriculum])

    if request.xhr?
      if @curriculum.save
        render json: @curriculum
      else
        render json: @curriculum.errors.full_messages, status: 422
      end
    else
      if @curriculum.save
        flash[:notice] = ["Curriculum created successfully."]
        redirect_to @curriculum
      else
        flash[:errors] ||= []
        flash[:errors] += @curriculum.errors.full_messages
        @definitions = Definition.all
        render :new
      end
    end
  end

  def edit
    @curriculum = Curriculum.find(params[:id])
    @definitions = Definition.all
    render :edit
  end

  def update
    @curriculum = Curriculum.find(params[:id])
    if @curriculum.update_attributes(params[:curriculum])
      flash[:notice] = ["Curriculum updated successfully."]
      redirect_to curriculum_url(@curriculum.id)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @curriculum.errors.full_messages
      @definitions = Definition.all
      render :edit
    end
  end

  def email
    @curriculum = Curriculum.find(params[:id])

    body = params[:email_body]
    emails_str = params[:recipient][:emails]
    emails = emails_str.split(",").map { |email| email.strip }

    emails.each do |email|
      msg = CurriculumMailer.curriculum_email(email, current_user, @curriculum, body)
      msg.deliver!
    end
    
    flash[:notice] = ["Curriculum emailed successfully."]

    redirect_to curriculum_url(@curriculum)
  end
end
