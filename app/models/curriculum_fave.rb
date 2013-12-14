class CurriculumFave < ActiveRecord::Base
  attr_accessible :user_id, :curriculum_id
  
  validates_uniqueness_of :user_id, scope: :curriculum_id
  
  belongs_to :user
  belongs_to :curriculum
end
