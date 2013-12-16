class DefinitionFave < ActiveRecord::Base
  attr_accessible :user_id, :definition_id

  validates_uniqueness_of :user_id, scope: :definition_id
  belongs_to :user
  belongs_to :definition

end
