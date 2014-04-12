require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :subdivision_id, :session_token, :password, :admin, :forgot_password_token, :name
  attr_accessor :password

  validates :email, :password_digest, :subdivision, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :admin, inclusion: { in: [true, false] }
  validates :email, uniqueness: true

  before_validation :ensure_session_token

  belongs_to :subdivision
  has_one :company, through: :subdivision
  has_many :definitions
  has_many :votes
  has_many(
    :sent_messages,
    class_name: "Message",
    foreign_key: :sender_id,
    primary_key: :id
  )
  has_many(
    :received_messages,
    class_name: "Message",
    foreign_key: :recipient_id,
    primary_key: :id
  )
  has_many(
    :definition_faves,
    class_name: "DefinitionFave",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
  )
  has_many :favorite_definitions, through: :definition_faves, source: :definition
  has_many(
    :curriculum_faves,
    class_name: "CurriculumFave",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
  )
  has_many :favorite_curriculums, through: :curriculum_faves, source: :curriculum

  def self.find_by_credentials(email, secret)
    user = User.find_by_email(email)

    return nil if user.nil?

    user.has_password?(secret) ? user : nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def has_password?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end

  def password=(secret)
    self.password_digest = BCrypt::Password.create(secret)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def self.generate_random_password
    SecureRandom.urlsafe_base64(4)
  end

  def set_forgot_pw_token!
    self.forgot_password_token = SecureRandom.urlsafe_base64(16)
    self.save!
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
