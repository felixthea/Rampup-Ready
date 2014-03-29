class CompaniesController < ApplicationController
	def new
		render :new, layout: "sales"
	end

	def create
		@company = Company.new(params[:company])
		@subdivision = @company.subdivisions.new(name: "General")
		@user = @subdivision.employees.new(params[:user])

		if @company.save
			render "Company, subdivision and user created."
		else
			all_errors = []
			all_errors = all_errors + @company.errors.full_messages + @subdivision.errors.full_messages + @user.errors.full_messages
      render json: all_errors, status: 422
		end
	end

	def destroy
	end
end
