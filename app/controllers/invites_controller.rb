class InvitesController < ApplicationController
	def new
		render :new, layout: "sales"
	end

	def create
		render json: JSON.parse(params[:invite_JSON][0])
	end

	def rsvp
		@full_name = params[:name] if params[:name]
		@email = params[:email] if params[:email]
		@inviter = params[:inviter] if params[:inviter]
		@company = Company.find_by_signup_token(params[:signup])
		@first_name = @full_name.split(" ")[0]

		if @company
			render :rsvp, layout: "sales"
		else
			redirect_to root_url
		end
	end
end
