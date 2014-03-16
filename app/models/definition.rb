class Definition < ActiveRecord::Base

  attr_accessible :word_id, :user_id, :body, :subdivision_id, :tag_ids, :company_id

  validates :word, :user_id, :body, presence: true

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

  def self.recently_added(current_co, limit)
    Definition.where('company_id = ?', current_co.id).order("definitions.created_at desc").first(limit)
  end

  belongs_to :word
  belongs_to :user
  belongs_to :subdivision
  belongs_to :company
  has_many(
    :examples,
    class_name: "Example",
    foreign_key: :definition_id,
    primary_key: :id,
    inverse_of: :definition,
    dependent: :destroy
  )
  has_many :votes
  has_many :taggings
  has_many :tags, through: :taggings, source: :tag
  has_many :curriculum_definitions
  has_many :curriculums, through: :curriculum_definitions, source: :curriculum
  has_many(
    :definition_faves,
    class_name: "DefinitionFave",
    foreign_key: :definition_id,
    primary_key: :id,
    dependent: :destroy
  )

  include PgSearch
  multisearchable against: :body
end
