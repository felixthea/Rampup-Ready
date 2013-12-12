class SubdivisionsController < ApplicationController
  before_filter :require_current_user!, except: [:index]

  def index
    @subdivisions = Subdivision.all
  end

  def new
    @subdivision = Subdivision.new
    render :new
  end

  def create
    @subdivision = Subdivision.new(params[:subdivision])
    if @subdivision.save
      flash[:notice] = ["Subdivision created!"]
      redirect_to subdivision_url(@subdivision)
    else
      flash[:errors] = [@subdivision.errors.full_messages]
      @subdivision = Subdivision.new
      render :new
    end
  end

  def show
    @subdivision = Subdivision.find(params[:id])
    render :show
  end
end
