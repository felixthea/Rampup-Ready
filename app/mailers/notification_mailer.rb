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

  def message_received_email(message)
    @message = message
    @sender = User.find(@message.sender_id)
    @recipient = User.find(@message.recipient_id)

    mail(
      from: @sender.email,
      to: @recipient.email,
      subject: "New message from #{@sender.email}"
    )
  end
end
