class CurriculumsController < ApplicationController
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
end
