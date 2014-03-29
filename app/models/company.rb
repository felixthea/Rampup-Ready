class Company < ActiveRecord::Base
  attr_accessible :name

  has_many(
  	:subdivisions,
  	class_name: "Subdivision",
  	foreign_key: :company_id,
  	primary_key: :id,
  	inverse_of: :company
	)

  has_many :words
  has_many :tags
  has_many :curriculums
  has_many :definitions
end
