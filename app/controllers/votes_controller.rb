class VotesController < ApplicationController

  before_filter :require_current_user!

  def create_upvote
    user_id = current_user.id
    definition_id = params[:id]

    possible_downvote = Vote.user_has_downvote?(user_id, definition_id)
    possible_downvote.destroy if possible_downvote

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

  def destroy_upvote
    # delete vote
  end

  def create_downvote
    user_id = current_user.id
    definition_id = params[:id]

    possible_upvote = Vote.user_has_upvote?(user_id, definition_id)
    possible_upvote.destroy if possible_upvote

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

  def destroy_downvote
    # delete vote
  end

end
