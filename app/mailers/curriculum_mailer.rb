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
end
