class VotesController < ApplicationController

  before_filter :require_current_user!

  def upvote
    user_id = current_user.id
    definition_id = params[:id]

    if Vote.user_has_voted?(user_id, definition_id)
      Vote.find_by_user_id_and_definition_id(user_id, definition_id).destroy
    end

    word = Definition.find(definition_id).word
    vote = Vote.new(user_id: user_id, definition_id: definition_id, vote: 1)

    if vote.save
      flash[:notice] = ["Upvoted"]
    else
      flash[:errors] ||= []
      flash[:errors] << vote.errors.full_messages
    end

    redirect_to word_url(word)
  end

  def downvote
    user_id = current_user.id
    definition_id = params[:id]

    if Vote.user_has_voted?(user_id, definition_id)
      Vote.find_by_user_id_and_definition_id(user_id, definition_id).destroy
    end

    word = Definition.find(definition_id).word
    vote = Vote.new(user_id: user_id, definition_id: definition_id, vote: -1)

    if vote.save
      flash[:notice] = ["Downvoted"]
    else
      flash[:errors] ||= []
      flash[:errors] << vote.errors.full_messages
    end

    redirect_to word_url(word)
  end
end
