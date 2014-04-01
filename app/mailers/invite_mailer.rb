class InviteMailer < ActionMailer::Base
  default from: "invite@rampupready.com"

  def invite_employee_email(name, email, company, inviter, invite_link)
  	@name = name
  	@email = email
  	@inviter = inviter
  	@company = company
  	@invite_link = invite_link
  	mail(
  		to: @email,
  		subject: "Please help me create the " + company + " glossary"
		)
  end
end
