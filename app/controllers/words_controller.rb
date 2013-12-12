class WordsController < ApplicationController

  before_filter :require_current_user!, only: [:new, :create, :destroy, :update, :edit]
  before_filter :require_admin!, only: [:destroy]

  def index
    @words = Word.all
    render :index
  end

  def show
    @word = Word.find(params[:id])
    @subdivisions = Subdivision.all
    @definitions = @word.definitions

    # @definitions.sort! { |defA, defB| defA
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
      flash[:errors] = [@word.errors.full_messages]
      render :new
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    redirect_to words_url
  end
end
