class Definition < ActiveRecord::Base
  attr_accessible :word_id, :user_id, :body, :subdivision_id

  validates :word_id, :user_id, :body, :subdivision_id, presence: true

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
end
