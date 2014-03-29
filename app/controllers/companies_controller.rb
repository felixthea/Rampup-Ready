class CompaniesController < ApplicationController
	def new
		render :new, layout: "sales"
	end

	def create
		@company = Company.new(params[:company])
		fail
		if @company.save
			redirect_to @company
		else
			render :new
		end
	end

	def destroy
	end
end
