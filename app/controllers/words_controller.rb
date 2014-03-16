class WordsController < ApplicationController

  before_filter :require_current_user!
  before_filter :require_admin!, only: [:destroy]
  before_filter :require_company!, only: [:show, :destroy]

  def index
    @words = Word.where('company_id = ?', current_co.id).order("words.name asc").page(params[:page])
    # @words = Word.order("words.name asc").page(params[:page])
    @curriculums = Curriculum.find_all_by_user_id(current_user.id)
    @word = Word.new
    @recent = Word.recently_added(current_co, 10);
    respond_to do |format|
      format.html
      format.json { render json: @words }
    end
  end

  def show
    @word = Word.find(params[:id])

    @subdivisions = Subdivision.where('company_id = ?', current_co.id)
    @definitions = @word.definitions
    @tags = Tag.where('company_id = ?', current_co.id)
    @related_words = @word.find_related_words(current_co)
    @word_tags = @word.find_word_tags
    @definition_faves = DefinitionFave.where('user_id = ?', current_user.id)

    @definitions.sort! { |defA, defB| defB.total_score <=> defA.total_score }
    render :show, layout: "entity"
  end

  def new
    @word = Word.new
    render :new
  end

  def create
    @word = Word.new(name: params[:word_name], company_id: current_co.id)

    @definition = @word.definitions.new(
      user_id: current_user.id,
      body: params[:definition_body],
      subdivision_id: params[:subdivision_id],
      tag_ids: params[:definition_tags],
      company_id: current_co.id
      )

    @example = @definition.examples.new(
      body: params[:definition_example][:body]
      )


    if request.xhr?
      if @word.save
        render json: { word: @word, definition: @definition, example: @example }
        # render partial: 'word', locals: {word: @word}
      elsif @word.errors.full_messages.include?("Name has already been taken")
        render json: Word.find_by_name(params[:word][:name]).id, status: 422
      else
        render json: @word.errors.full_messages, status: 422
      end
    else
      if @word.save
        flash[:notice] = ["#{@word.name} created successfully."]
        redirect_to @word
      else
        flash[:errors] = @word.errors.full_messages
        render :new
      end
    end
  end

  def destroy
    word = Word.find(params[:id])
    if word.destroy
      render :json => { status: 200 }
    else
      render :json => word.errors.full_messages, status: 422
    end
  end

  private

  def require_company!
    redirect_to new_session_url if Word.find(params[:id]).company_id != current_co.id
  end
end
