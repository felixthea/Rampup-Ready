class VotesController < ApplicationController

  before_filter :require_current_user!

  def create_upvote
    user_id = current_user.id
    definition_id = params[:id]
    definition = Definition.find(definition_id)

    possible_downvote = Vote.user_has_downvote?(user_id, definition_id)
    possible_downvote.destroy if possible_downvote

    word = Definition.find(definition_id).word
    vote = Vote.new(user_id: user_id, definition_id: definition_id, vote: 1)

    if request.xhr?
      if vote.save
        render json: { total: definition.total_score, upvotes: definition.sum_upvotes, downvotes: definition.sum_downvotes }
      else
        render json: vote.errors.full_messages, status: 422
      end
    else
      if vote.save
        flash[:notice] = ["Upvoted"]
      else
        flash[:errors] ||= []
        flash[:errors] << vote.errors.full_messages
      end

      redirect_to word_url(word)
    end
  end

  def destroy_upvote
    # delete vote
  end

  def create_downvote
    user_id = current_user.id
    definition_id = params[:id]
    definition = Definition.find(definition_id)

    possible_upvote = Vote.user_has_upvote?(user_id, definition_id)
    possible_upvote.destroy if possible_upvote

    word = Definition.find(definition_id).word
    vote = Vote.new(user_id: user_id, definition_id: definition_id, vote: -1)

    if request.xhr?
      if vote.save
        render json: { total: definition.total_score, upvotes: definition.sum_upvotes, downvotes: definition.sum_downvotes }
      else
        render json: vote.errors.full_messages, status: 422
      end
    else
      if vote.save
        flash[:notice] = ["Downvoted"]
      else
        flash[:errors] ||= []
        flash[:errors] << vote.errors.full_messages
      end

      redirect_to word_url(word)
    end
  end

  def destroy_downvote
    # delete vote
  end

end
