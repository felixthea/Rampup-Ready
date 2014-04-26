class InviteMailer < ActionMailer::Base
  default from: "invite@rampupready.com"

  def invite_help_email(name, email, company, inviter, invite_link, cc_inviter, inviter_email)
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

  def invite_employee_email(employee_name, employee_email, company_name, invite_link, inviter_name)
    @employee_name = employee_name
    @employee_email = employee_email
    @company_name = company_name
    @invite_link = invite_link
    @inviter_name = inviter_name

    mail(
      to: @employee_email,
      subject: "Start learning words and definitions in the new " + @company_name + " glossary."
    )
  end
end
