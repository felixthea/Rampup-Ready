class SearchesController < ApplicationController

  def create
    @keyword = params[:keyword]
    @word_results = []
    @tag_results = []
    PgSearch.multisearch(@keyword).each do |result|
      if result.searchable_type == "Word"
        word = Word.find(result.searchable_id)
        @word_results << word unless @word_results.include?(word)
      elsif result.searchable_type == "Definition"
        word = Definition.find(result.searchable_id).word
        @word_results << word unless @word_results.include?(word)
      elsif result.searchable_type == "Tag"
        @tag_results << Tag.find(result.searchable_id)
      end
    end
    
    if request.xhr?
      render :json => { results: @word_results }
    else
      render :results
    end
  end
end
