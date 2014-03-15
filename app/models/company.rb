class Company < ActiveRecord::Base
  attr_accessible :name

  has_many :subdivisions
  has_many :words
  has_many :tags
  has_many :curriculums
end
