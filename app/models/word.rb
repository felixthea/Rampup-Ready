class Word < ActiveRecord::Base
  attr_accessible :name

  validates :name, uniqueness: true, presence: true

  has_many(
    :definitions,
    class_name: "Definition",
    foreign_key: :word_id,
    primary_key: :id
  )
end
