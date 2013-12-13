class Message < ActiveRecord::Base
  attr_accessible :subject, :body, :sender_id, :recipient_id, :read

  validates :subject, :body, presence: true
  validates :read, :inclusion => {:in => [true, false]}

  belongs_to :sender
  belongs_to :recipient
end
