class Vote < ActiveRecord::Base
  attr_accessible :vote, :user_id, :definition_id

  validates :vote, :user_id, :definition_id, presence: true
  validates_uniqueness_of :user_id, :scope => :vote, message: "already voted."

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :definition,
    class_name: "Definition",
    foreign_key: :definition_id,
    primary_key: :id
  )


  def self.user_has_upvote?(user_id, definition_id)
    vote = Vote.find_by_user_id_and_definition_id(user_id, definition_id)
    return false if vote.nil?

    if vote.vote == 1
      return vote
    else
      return false
    end
  end

  def self.user_has_downvote?(user_id, definition_id)
    vote = Vote.find_by_user_id_and_definition_id(user_id, definition_id)
    return false if vote.nil?

    if vote.vote == -1
      return vote
    else
      return false
    end
  end
end
