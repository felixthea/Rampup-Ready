class CurriculumsController < ApplicationController

  before_filter :require_curriculum_creator_or_admin!, only: [:edit, :update, :destroy]

  def index
    @curriculums = Curriculum.all
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
    recipient = User.find_by_email(params[:recipient][:email])
    if recipient
      msg = CurriculumMailer.curriculum_email(recipient, current_user, @curriculum)
      msg.deliver!
      flash[:notice] = ["Curriculum emailed successfully."]

      redirect_to curriculum_url(@curriculum)
    else
      flash[:errors] = ["User not found.  Please create an account for the user."]
      render :show
    end
  end
end
