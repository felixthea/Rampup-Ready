class TagsController < ApplicationController

  before_filter :require_current_user!
  before_filter :require_admin!, only: [:destroy]

  def index
    @tags = Tag.all
    render :index
  end

  def show
    @tag = Tag.find(params[:id])
    @definitions = Definition.joins("INNER JOIN taggings ON definitions.id = taggings.definition_id")
                              .joins("INNER JOIN tags ON tags.id = taggings.tag_id")
                              .joins("INNER JOIN words ON words.id = definitions.word_id")
                              .where("tags.id = ?", @tag.id)
                              .order("words.name asc")
                              .page(params[:page])
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
      flash[:errors] = @tag.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      flash[:notice] = ["Tag deleted."]
    else
      flash[:errors] = @tag.errors.full_messages
    end

    redirect_to tags_url
  end
end
