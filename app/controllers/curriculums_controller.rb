class CurriculumsController < ApplicationController

  before_filter :require_current_user!
  before_filter :require_curriculum_creator_or_admin!, only: [:edit, :update, :destroy]

  def index
    @my_curriculums = Curriculum.find_all_by_user_id(current_user.id)
    @public_curriculums = Curriculum.where('company_id = ? AND make_private = ?', current_co.id, false)
    @public_curriculums.reject! { |public_curriculum| @my_curriculums.include?(public_curriculum) } 
    @curriculums = @my_curriculums + @public_curriculums
    render :index
  end

  def show
    @curriculum = Curriculum.find(params[:id])
    @definitions = @curriculum.definitions
    render :show
  end

  def new
    @curriculum = Curriculum.new
    @definitions = Definition.all
    render :new
  end

  def create
    params[:curriculum][:user_id] = current_user.id
    params[:curriculum][:company_id] = current_co.id
    params[:curriculum][:definition_ids].uniq!

    @curriculum = Curriculum.new(params[:curriculum])

    if request.xhr?
      if @curriculum.save
        render partial: 'curriculum', locals: { curriculum: @curriculum }
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
    @curriculum = Curriculum.find(params[:curriculum_id])
    return unless @curriculum.company_id == current_co.id

    body = params[:email_body]
    emails_str = params[:email_addresses]
    emails = emails_str.split(",").map { |email| email.strip }

    emails.each do |email|
      msg = CurriculumMailer.curriculum_email(email, current_user, @curriculum, body)
      msg.deliver!
    end

    render json: { message: "Success", status: 200}
  end
end
