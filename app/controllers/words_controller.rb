class WordsController < ApplicationController

  before_filter :require_current_user!
  before_filter :require_admin!, only: [:destroy]

  def index
    @words = Word.all
    @word = Word.new
    render :index
  end

  def show
    @word = Word.find(params[:id])
    @subdivisions = Subdivision.all
    @definitions = @word.definitions
    @tags = Tag.all
    @related_words = @word.find_related_words

    @definitions.sort! { |defA, defB| defB.total_score <=> defA.total_score }
    render :show
  end

  def new
    @word = Word.new
    render :new
  end

  def create
    @word = Word.new(params[:word])
    if @word.save
      flash[:notice] = ["#{@word.name} created successfully."]
      redirect_to @word
    else
      flash[:errors] = @word.errors.full_messages
      render :new
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    redirect_to words_url
  end
end
