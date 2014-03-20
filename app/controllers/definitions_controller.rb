class DefinitionsController < ApplicationController

  before_filter :require_current_user!, only: [:new, :create]
  before_filter :require_author_or_admin!, only: [:edit, :update, :destroy]

  def new
    @definition = Definition.new
  end

  def create
    word_id = params[:word_id]
    word = Word.find(word_id)

    redirect_to new_sessions_url if word.company_id != current_co.id

    def_body = params[:definition_body]
    subdivision_id = params[:subdivision_id]
    
    user_id = current_user.id
    tag_ids = params[:definition_tags]
    company_id = current_co.id
    @definition = Definition.new(body: def_body, subdivision_id: subdivision_id, word_id: word_id, user_id: user_id, tag_ids: tag_ids, company_id: company_id)
    
    @definition.examples.new(params[:definition_example]) unless params[:definition_example][:body].empty?

    if request.xhr? && params[:from_modal] == "true"
      if @definition.save
        definition_index = word.definitions.index(@definition)
        render json: { definition: @definition, index: definition_index }
      else
        render json: {message: @definition.errors.full_messages}
      end
    elsif request.xhr?
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

    redirect_to new_session_url if @definition.word.company_id != current_co.id

    @subdivisions = Subdivision.all
    @example = @definition.examples[0]
    @tags = Tag.all
    render :edit
  end

  def update
    @definition = Definition.find(params[:id])
    @example = @definition.examples[0]
    @subdivisions = Subdivision.all

    if request.xhr?
      @definition.body = params[:definition][:body]
      if @definition.save
        render json: { body: @definition.body }
      else
        render json: { errors: @definition.errors.full_messages, params: params[:definition][:body] }, status: 422
      end
    else
      ActiveRecord::Base.transaction do
        @definition.update_attributes(params[:definition])
        @example.update_attributes(params[:example]) if params[:example]
      end

      if @definition.valid? && (params[:example].blank? || @example.valid?)
        flash[:notice] = ["Definitition updated for #{@definition.word.name}"]
        redirect_to word_url(@definition.word.id)
      else
        flash.now[:errors] ||= []
        flash.now[:errors] += @definition.errors.full_messages
        flash.now[:errors] += @example.errors.full_messages
        render :edit
      end
    end

  end

  def destroy
    definition = Definition.find(params[:id])
    word = definition.word
    definition.destroy

    if word.company_id == current_co.id
      if request.xhr?
        render json: {status: 200}
      else
        flash[:notice] = ["Definition deleted from #{word.name}."]
        redirect_to word_url(word)
      end
    else
      redirect_to new_sessions_url
    end

  end

  def new_email_definition
    @definition = Definition.find(params[:id])
    @recipients = User.all
    @messages = Message.all
    @message = Message.new
    @message.subject = "New definition to learn!"
    @message.body = "#{@definition.word.name}: #{@definition.body}"
    render 'messages/new'
  end
end
