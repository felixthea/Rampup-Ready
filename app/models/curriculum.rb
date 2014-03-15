class Curriculum < ActiveRecord::Base
  attr_accessible :user_id, :name, :curriculum_definition_id, :description, :definition_ids, :make_private

  validates :user_id, :name, :description, :definitions, presence: true

  has_many :curriculum_definitions
  has_many :definitions, through: :curriculum_definitions, source: :definition
  belongs_to :user
  belongs_to :company
  has_many(
    :curriculum_faves,
    class_name: "CurriculumFave",
    foreign_key: :curriculum_id,
    primary_key: :id,
    dependent: :destroy
  )

  def self.recently_added(current_co, limit)
    Curriculum.where('company_id = ?', current_co.id).order("curriculums.created_at desc").first(limit)
  end
end
