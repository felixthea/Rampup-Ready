class CurriculumFavesController < ApplicationController
  def favorite
    user_id = current_user.id
    curriculum_id = params[:id]
    curriculum_fave = CurriculumFave.new(user_id: user_id, curriculum_id: curriculum_id)
    if curriculum_fave.save
      flash[:notice] = ["Curriculum favorited!"]
    else
      flash[:error] ||= []
      flash[:error] << curriculum_fave.errors.full_messages
    end
    
    redirect_to curriculum_url(curriculum_id)
  end
  
  def unfavorite
    curriculum_id = params[:id]
    CurriculumFave.find_by_curriculum_id_and_user_id(curriculum_id, current_user.id).destroy
    flash[:notice] = ["Curriculum unfavorited!"]
    redirect_to curriculum_url(curriculum_id)
  end
end
