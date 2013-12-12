class Tagging < ActiveRecord::Base
  attr_accessible :tag_id, :definition_id

  validates :tag_id, :definition_id, presence: true
  validates_uniqueness_of :tag_id, :scope => :definition_id, message: "Tag already applied."

  belongs_to(
    :tag,
    class_name: "Tag",
    foreign_key: :tag_id,
    primary_key: :id
  )

  belongs_to(
    :definition,
    class_name: "Definition",
    foreign_key: :definition_id,
    primary_key: :id
  )
end
