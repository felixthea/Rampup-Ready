class InvitesController < ApplicationController
	def new
		@invite_url = "http://rampupready.com/invite/rsvp?signup=" + current_co.signup_token + "&inviter=" + current_user.name.split(" ")[0]
		render :new, layout: "sales"
	end

	def create
		invitees = params[:invite_JSON]
		cc_inviter = params[:cc]

		invitees.each do |invitee|
			inviteeInfo = JSON.parse(invitee)
			name = inviteeInfo["name"].split(" ")[0]
			email = inviteeInfo["email"]
			inviter = current_user.name.split(" ")[0]
			inviter_email = current_user.email

			invite_link = "/invite/rsvp?signup=" + current_co.signup_token + "&name=" + name + "&inviter=" + inviter + "&email=" + email

			msg = InviteMailer.invite_employee_email(name, email, current_co.name, inviter, invite_link, cc_inviter, inviter_email)
			msg.deliver!
		end
	end

	def rsvp
		@full_name = params[:name] if params[:name]
		@email = params[:email] if params[:email]
		@inviter = params[:inviter] if params[:inviter]
		@company = Company.find_by_signup_token(params[:signup])
		@first_name = @full_name.split(" ")[0] if @full_name

		if @company
			render :rsvp, layout: "sales"
		else
			redirect_to root_url
		end
	end
end
