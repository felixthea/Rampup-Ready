class CurriculumMailer < ActionMailer::Base
  default from: "from@example.com"

  def curriculum_email(recipient, sender, curriculum)
    @recipient = recipient
    @sender = sender
    @curriculum = curriculum
    mail(
      to: @recipient.email,
      subject: "New Curriculum"
    )
  end

  # def definition_email(recipient, sender, text)
  #   @recipient = recipient
  #   @sender = sender
  #   @text = text
  #   mail(
  #     to: @recipient.email,
  #     subject: "Here's a new word to learn!"
  #   )
  # end
end
