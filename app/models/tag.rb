class Tag < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true, uniqueness: true

  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :tag_id,
    primary_key: :id
  )

  has_many :tagged_definitions, through: :taggings, source: :definition
  belongs_to :company

  include PgSearch
  multisearchable against: :name

end
