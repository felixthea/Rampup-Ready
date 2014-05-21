class Company < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: { message: "of company or organization can't be blank" }
  before_validation :ensure_signup_token

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

  def self.generate_signup_token
    SecureRandom.urlsafe_base64(16)
  end

  private

  def ensure_signup_token
    self.signup_token ||= self.class.generate_signup_token
  end

end
