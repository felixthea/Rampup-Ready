class Definition < ActiveRecord::Base
  attr_accessible :word_id, :user_id, :body, :subdivision_id

  validates :word_id, :user_id, :body, :subdivision_id, presence: true

  def sum_upvotes
    upvotes = all_votes.select { |vote| vote == 1 }
    upvote_sum = upvotes.inject(0) { |sum, value| sum + value }
    return upvote_sum
  end

  def sum_downvotes
    downvotes = all_votes.select { |vote| vote == -1 }
    downvote_sum = downvotes.inject(0) { |sum, value| sum + value }
    return downvote_sum
  end

  def all_votes
    vote_objects = Vote.find_all_by_definition_id(self.id)
    votes = vote_objects.map { |vote_object| vote_object.vote }
    return votes
  end

  def total_score
    total_score = sum_upvotes + sum_downvotes
    return total_score
  end

  belongs_to(
    :word,
    class_name: "Word",
    foreign_key: :word_id,
    primary_key: :id
  )

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :subdivision,
    class_name: "Subdivision",
    foreign_key: :subdivision_id,
    primary_key: :id
  )

  has_many(
    :examples,
    class_name: "Example",
    foreign_key: :definition_id,
    primary_key: :id,
    inverse_of: :definition
  )

  has_many(
    :votes,
    class_name: "Votes",
    foreign_key: :definition_id,
    primary_key: :id
  )
end
