class CurriculumMailer < ActionMailer::Base
  default from: "info@rampupready.com"

  def curriculum_email(recipient, sender, curriculum, body)
    @recipient = recipient
    @sender = sender
    @curriculum = curriculum
    @body = body
    mail(
      from: @sender.email,
      to: @recipient.email,
      subject: "New Curriculum"
    )
  end

end
