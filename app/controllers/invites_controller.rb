class InvitesController < ApplicationController
	before_filter :require_admin!, only: [:new, :new_employees, :create_employees]

	def new
		@invite_url = "http://rampupready.com/invite/rsvp?signup=" + current_co.signup_token + "&inviter=" + current_user.name.split(" ")[0]
		render :new, layout: "sales"
	end

	def create
		invitees = params[:invite_JSON]
		cc_inviter = params[:cc]

		invitees.each do |invitee|
			inviteeInfo = JSON.parse(invitee)
			full_name = inviteeInfo["name"]
			name = inviteeInfo["name"].split(" ")[0]
			email = inviteeInfo["email"]
			inviter = current_user.name.split(" ")[0]
			inviter_email = current_user.email

			invite_link = "http://rampupready.com/invite/rsvp?signup=" + current_co.signup_token + "&name=" + full_name + "&inviter=" + inviter + "&email=" + email

			msg = InviteMailer.invite_help_email(name, email, current_co.name, inviter, invite_link, cc_inviter, inviter_email)
			msg.deliver!
		end
	end

	def rsvp
		@full_name = params[:name] if params[:name]
		@email = params[:email] if params[:email]
		@inviter = params[:inviter] if params[:inviter]
		@company = Company.find_by_signup_token(params[:signup])
		@first_name = @full_name.split(" ")[0]	 if @full_name

		if @company
			render :rsvp, layout: "sales"
		else
			redirect_to root_url
		end
	end

	def new_employees
		@invited_employees = Invite.find_all_by_company_id(current_co.id)
		@generic_invite_link = "http://rampupready.com/signup?signup=" + current_co.signup_token
		render :employees, layout: "sales"
	end

	def create_employees
		name = params[:invite_JSON][:name]
		email = params[:invite_JSON][:email]

		invite = Invite.new(email: email, name: name, company_id: current_co.id)
		invite_link = "http://rampupready.com/signup?signup=" + current_co.signup_token + "&name=" + name + "&email=" + email

		if invite.save
			msg = InviteMailer.invite_employee_email(name, email, current_co.name, invite_link, current_user.name)
			msg.deliver!
			render json: { message: "success" }, status: 200
		else
			render json: { message: "invite failed" }, status: 422
		end
	end

	def employee_signup
		@full_name = params[:name] if params[:name]
		@email = params[:email] if params[:email]
		@company = Company.find_by_signup_token(params[:signup])
		@first_name = @full_name.split(" ")[0] if @full_name

		render :employee_signup, layout: "sales"
	end
end
