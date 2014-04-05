class Invite < ActiveRecord::Base
  attr_accessible :name, :company_id, :email

  validates :email, :uniqueness => {:scope => :company_id}
end
