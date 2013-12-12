module DefinitionsHelper

  def sum_upvotes(definition_id)
    upvotes = all_votes(definition_id).select { |vote| vote == 1 }
    upvote_sum = upvotes.inject(0) { |sum, value| sum + value }
    return upvote_sum
  end

  def sum_downvotes(definition_id)
    downvotes = all_votes(definition_id).select { |vote| vote == -1 }
    downvote_sum = downvotes.inject(0) { |sum, value| sum + value }
    return downvote_sum
  end

  def all_votes(definition_id)
    vote_objects = Vote.find_all_by_definition_id(definition_id)
    votes = vote_objects.map { |vote_object| vote_object.vote }
    return votes
  end

  def total_score(definition_id)
    total_score = sum_upvotes(definition_id) + sum_downvotes(definition_id)
    return total_score
  end
end
