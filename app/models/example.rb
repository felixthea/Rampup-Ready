class Example < ActiveRecord::Base
  attr_accessible :body, :definition_id
  
  validates :body, :definition, presence: true
  
  belongs_to(
    :definition,
    class_name: "Definition",
    foreign_key: :defintion_id,
    primary_key: :id,
    inverse_of: :examples
  )
  
end
