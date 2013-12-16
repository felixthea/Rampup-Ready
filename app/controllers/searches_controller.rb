class SearchesController < ApplicationController

  def create
    @keyword = params[:keyword]
    @results = Word.where(["name LIKE :name", {name: "%#{@keyword}%"}])
    render :results
  end
end
