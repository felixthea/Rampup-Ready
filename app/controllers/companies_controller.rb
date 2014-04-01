class CompaniesController < ApplicationController
	def new
		render :new, layout: "sales"
	end

	def create
		@company = Company.new(params[:company])
		@subdivision = @company.subdivisions.new(name: "General")
		@user = @subdivision.employees.new(params[:user])

		if @company.save
			log_user_in!(@user, invite_url)
		else
			all_errors = []
			@company.errors.messages.except!(:subdivisions)
			all_errors = all_errors + @company.errors.full_messages + @user.errors.full_messages
      # render json: all_errors, status: 422
      flash.now[:errors] = all_errors
      render :new, layout: "sales"
		end
	end

	def destroy
	end
end
