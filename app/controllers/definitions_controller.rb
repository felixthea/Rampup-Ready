class DefinitionsController < ApplicationController

  before_filter :require_current_user!, only: [:new, :create]

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
end
