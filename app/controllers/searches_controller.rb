class SearchesController < ApplicationController

  before_filter :require_current_user!

  def create
    @keyword = params[:keyword]
    @word_results = []
    @tag_results = []
    PgSearch.multisearch(@keyword).each do |result|
      if result.searchable_type == "Word"
        word = Word.find(result.searchable_id)
      elsif result.searchable_type == "Definition"
        word = Definition.find(result.searchable_id).word
      else
        word = nil
      end

      if word && !@word_results.include?(word) && word.company_id && word.company_id == current_co.id
        @word_results << word
      end

    end
    
    if request.xhr?
      render :json => { results: @word_results.as_json(include: :definitions) }
    else
      render :results
    end
  end
end
