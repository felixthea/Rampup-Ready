class AuthMailer < ActionMailer::Base
  default from: "resetpassword@rampupready.com"
  
  def forgot_password_email(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Reset your password"
    )
  end
end
