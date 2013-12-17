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

    if request.xhr?
      if @definition_fave.save
        render :json => { status: 200 }
      else
        render :json => @definition_fave.errors.full_messages, status: 422
      end
    else
      if @definition_fave.save
        flash[:notice] = ["Definition favorited!"]
        redirect_to word_url(word.id)
      else
        flash[:error] ||= []
        flash[:error] += @definition_fave.errors.full_messages
        redirect_to word_url(word.id)
      end
    end
  end

  def unfavorite
    definition_id = params[:id]
    word = Definition.find(definition_id).word

    definition_fave = DefinitionFave.find_by_definition_id_and_user_id(definition_id, current_user.id).destroy

    if request.xhr?
      if !definition_fave.persisted?
        render :json => { status: 200 }
      else
        render :json => definition_fave.errors.full_messages, status: 422
      end
    else
      if !definition_fave.persisted?
        flash[:notice] = ["Definition unfavorited!"]
        redirect_to word_url(word.id)
      else
        flash[:errors] ||= [];
        flash[:errors] += definition_fave.errors.full_messages
      end
    end
  end

end
