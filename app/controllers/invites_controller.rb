class InvitesController < ApplicationController
	def new
		render :new, layout: "sales"
	end

	def create
		render json: JSON.parse(params[:invite_JSON][0])
	end

end
