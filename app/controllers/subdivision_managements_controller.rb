class SubdivisionManagementsController < ApplicationController
  def new
    @users = User.all
    @subdivisions = Subdivision.all
    render :new
  end

  def create
    user_id = params[:subdivisionmanagement][:user_id]
    subdivision_id = params[:subdivisionmanagement][:subdivision_id]

    @subdivisionmanagement = SubdivisionManagement.new({user_id: user_id, subdivision_id: subdivision_id})
    if @subdivisionmanagement.save
      flash[:notice] = "#{User.find(user_id).email} assigned as manager of #{Subdivision.find(subdivision_id).name}"
      redirect_to subdivision_url(subdivision_id)
    else
      flash.now[:errors] = @subdivisionmanagement.errors.full_messages
      render :new
    end
  end

end
