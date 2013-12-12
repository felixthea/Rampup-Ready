class TagsController < ApplicationController

  def index
    @tags = Tag.all
    render :index
  end

  def show
    @tag = Tag.find(params[:id])
    render :show
  end

  def new
    @tag = Tag.new
    render :new
  end

  def create
    @tag = Tag.new(params[:tag])
    if @tag.save
      flash[:notice] = ["Tag created!"]
      redirect_to tag_url(@tag)
    else
      flash[:errors] ||= []
      flash[:errors] << @tag.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
