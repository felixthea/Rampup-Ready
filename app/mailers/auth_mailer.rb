class AuthMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def forgot_password_email(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Reset your password"
    )
  end
end
