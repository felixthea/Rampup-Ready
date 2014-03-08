class WordsController < ApplicationController

  before_filter :require_current_user!
  before_filter :require_admin!, only: [:destroy]

  def index
    @words = Word.order("words.name asc").page(params[:page])
    @curriculums = Curriculum.find_all_by_user_id(current_user.id)
    @word = Word.new
    respond_to do |format|
      format.html
      format.json { render json: @words }
    end
  end

  def show
    @word = Word.find(params[:id])
    @subdivisions = Subdivision.all
    @definitions = @word.definitions
    @tags = Tag.all
    @related_words = @word.find_related_words
    @definition_faves = DefinitionFave.all

    @definitions.sort! { |defA, defB| defB.total_score <=> defA.total_score }
    render :show
  end

  def new
    @word = Word.new
    render :new
  end

  def create
    @word = Word.new(params[:word])

    if request.xhr?
      if @word.save
          render partial: 'word', locals: {word: @word}
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
    Word.find(params[:id]).destroy
    render :json => { status: 200 }
  end
end
