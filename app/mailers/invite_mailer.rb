class InviteMailer < ActionMailer::Base
  default from: "invite@rampupready.com"

  def invite_employee_email(name, email, company, inviter, invite_link, cc_inviter, inviter_email)
  	@name = name
  	@email = email
  	@inviter = inviter
  	@company = company
  	@invite_link = invite_link

    if cc_inviter
      mail(
        to: @email,
        subject: "Please help me create the " + company + " glossary",
        cc: inviter_email
      )
    else
      mail(
        to: @email,
        subject: "Please help me create the " + company + " glossary"
      )
    end
  	
  end
end
