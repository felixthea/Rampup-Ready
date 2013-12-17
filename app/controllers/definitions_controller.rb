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
    def_body = params[:definition][:body]
    subdivision_id = params[:definition][:subdivision_id]
    word_id = params[:word_id]
    user_id = current_user.id
    tag_ids = params[:definition][:tag_ids]
    @definition = Definition.new(body: def_body, subdivision_id: subdivision_id, word_id: word_id, user_id: user_id, tag_ids: tag_ids)
    @definition.examples.new(params[:example])

    if request.xhr?
      if @definition.save
        render partial: 'definitions/definition', locals: { definition: @definition }
      else
        render :json => @definition.errors.full_messages, status: 422
      end
    else
      if @definition.save
        flash[:notice] = ["Thanks! Your definition was added!"]
        redirect_to word_url(word_id)
      else
        flash[:errors] = @definition.errors.full_messages
        redirect_to word_url(word_id)
      end
    end
  end

  def edit
    @definition = Definition.find(params[:id])
    @subdivisions = Subdivision.all
    @example = @definition.examples[0]
    @tags = Tag.all
    render :edit
  end

  def update
    @definition = Definition.find(params[:id])
    @example = @definition.examples[0]
    @subdivisions = Subdivision.all

    ActiveRecord::Base.transaction do
      @definition.update_attributes(params[:definition])
      @example.update_attributes(params[:example])
    end

    if @definition.valid? && @example.valid?
      flash[:notice] = ["Definitition updated for #{@definition.word.name}"]
      redirect_to word_url(@definition.word.id)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @definition.errors.full_messages
      flash.now[:errors] += @example.errors.full_messages
      render :edit
    end

  end

  def destroy
    definition = Definition.find(params[:id])
    word = definition.word
    definition.destroy

    if request.xhr?
      render json: {status: 200}
    else
      flash[:notice] = ["Definition deleted from #{word.name}."]
      redirect_to word_url(word)
    end

  end

  def new_email_definition
    @definition = Definition.find(params[:id])
    @recipients = User.all
    @messages = Message.all
    @message = Message.new
    @message.subject = "New definition to learn!"
    @message.body = "#{@definition.word.name}: #{@definition.body}"
    render 'messages/index'
  end
end
