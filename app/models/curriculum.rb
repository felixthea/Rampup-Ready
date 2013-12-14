class Curriculum < ActiveRecord::Base
  attr_accessible :user_id, :name, :curriculum_definition_id, :description, :definition_ids

  validates :user_id, :name, :description, :definitions, presence: true

  has_many :curriculum_definitions
  has_many :definitions, through: :curriculum_definitions, source: :definition
  has_many :curriculum_faves
end
