class CurriculumDefinition < ActiveRecord::Base
  attr_accessible :definition_id, :curriculum_id

  validates :definition_id, :curriculum_id, presence: true
  validates_uniqueness_of :definition_id, :scope => :curriculum_id, message: "Definition already added."

  belongs_to :curriculum
  belongs_to :definition

end
