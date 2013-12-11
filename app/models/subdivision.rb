class Subdivision < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many(
    :employees,
    class_name: "User",
    foreign_key: :subdivision_id,
    primary_key: :id
  )

  has_many(
    :definitions,
    class_name: "Definition",
    foreign_key: :subdivision_id,
    primary_key: :id
  )
end
