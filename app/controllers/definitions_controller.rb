class DefinitionsController < ApplicationController

  before_filter :require_current_user!, only: [:new, :create]
  before_filter :require_author_or_admin!, only: [:edit, :update, :destroy]

  def show
    @definition = Definition.find(params[:id])
    render :show
  end

  def new
    @definition = Definition.new
  end

  def create
    body = params[:definition][:body]
    subdivision_id = params[:definition][:subdivision_id]
    word_id = params[:word_id]
    user_id = current_user.id

    @definition = Definition.new({body: body, subdivision_id: subdivision_id, word_id: word_id, user_id: user_id})
    if @definition.save
      flash[:notice] = "Thanks!  Your definition was added!"
      redirect_to word_url(word_id)
    else
      flash[:errors] = @definition.errors.full_mesages
      render :new
    end
  end

  def edit
    @definition = Definition.find(params[:id])
    render :edit
  end

  def update
    @definition = Definition.find(params[:id])
    if @definition.update_attributes(params[:definition])
      flash[:notice] = "Definitition updated for #{@definition.word.name}"
      redirect_to word_url(@definition.word.id)
    else
      flash.now[:errors] = @definition.errors.full_messages
      render :edit
    end
  end

  def destroy
    definition = Definition.find(params[:id])
    word = definition.word
    definition.destroy
    flash[:notice] = "Definition deleted from #{word.name}."
    redirect_to word_url(word)
  end

end
