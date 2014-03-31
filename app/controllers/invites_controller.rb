class InvitesController < ApplicationController
	def new
		render :new, layout: "sales"
	end

	def create
		render json: JSON.parse(params[:invite_JSON][0])
	end

	def rsvp
		signup_token = params[:signup]
		@name = params[:name] if params[:name]
		@email = params[:email] if params[:email]
		@company = Company.find_by_signup_token(signup_token)

		if @company
			render :rsvp, layout: "sales"
		else
			redirect_to root_url
		end
	end
end
