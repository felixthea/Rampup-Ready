class NotificationMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def admin_sign_up_user_email(user, sender, password)
    @user = user
    @sender = sender
    @password = password
    mail(
      to: user.email,
      subject: "You're invited!"
    )
  end
end
