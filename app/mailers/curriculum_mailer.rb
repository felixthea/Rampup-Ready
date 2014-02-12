class CurriculumMailer < ActionMailer::Base
  default from: "info@rampupready.com"

  def curriculum_email(email, sender, curriculum, body)
    @email = email
    @sender = sender
    @curriculum = curriculum
    @body = body
    mail(
      from: @sender.email,
      to: @email,
      subject: "New Curriculum"
    )
  end

end
