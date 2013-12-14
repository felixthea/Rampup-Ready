class DefinitionFavesController < ApplicationController
  
  before_filter :require_current_user!, only: [:favorite, :unfavorite]
  
  def index
    @definition_faves = current_user.favorite_definitions
    render :index
  end
  
  def favorite
    definition_id = params[:id]
    word = Definition.find(definition_id).word
    user_id = current_user.id
    @definition_fave = DefinitionFave.new(definition_id: definition_id, user_id: user_id)
    if @definition_fave.save
      flash[:notice] = ["Definition favorited!"]
    else
      flash[:error] ||= []
      flash[:error] += @definition_fave.errors.full_messages
    end
    redirect_to word_url(word.id)
  end
  
  def unfavorite
    definition_id = params[:id]
    word = Definition.find(definition_id).word
    
    DefinitionFave.find_by_definition_id_and_user_id(definition_id, current_user.id).destroy
    flash[:notice] = ["Definition unfavorited!"]
    redirect_to word_url(word.id)
  end
  
end
