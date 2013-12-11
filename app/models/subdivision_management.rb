class SubdivisionManagement < ActiveRecord::Base
  attr_accessible :user_id, :subdivision_id

  validates :user_id, :subdivision_id, presence: true

  belongs_to(
    :manager,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :subdivision,
    class_name: "Subdivision",
    foreign_key: :subdivision_id,
    primary_key: :id
  )
end
