class Tag < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true, uniqueness: true

  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :tag_id,
    primary_key: :id
  )

end
