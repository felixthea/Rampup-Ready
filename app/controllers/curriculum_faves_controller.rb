class CurriculumFavesController < ApplicationController
  def favorite
    user_id = current_user.id
    curriculum_id = params[:id]
    curriculum_fave = CurriculumFave.new(user_id: user_id, curriculum_id: curriculum_id)

    if curriculum_fave.save
      if request.xhr?
        render :json => {} , status: 200
      else
        flash[:notice] = ["Curriculum favorited!"]
        redirect_to curriculum_url(curriculum_id)
      end
    else
      if request.xhr?
        render :json => curriculum_fave.errors.full_messages, status: 422
      else
        flash[:error] ||= []
        flash[:error] << curriculum_fave.errors.full_messages
        redirect_to curriculum_url(curriculum_id)
      end
    end
  end

  def unfavorite
    curriculum_id = params[:id]
    curriculum_fave = CurriculumFave.find_by_curriculum_id_and_user_id(curriculum_id, current_user.id).destroy

    if curriculum_fave.persisted?
      if request.xhr?
        render :json => {}, status: 422
      else
        flash[:errors] = ["Curriculum was not unfavorited!"]
      end
    else
      if request.xhr?
        render :json => {}, status: 200
      else
        flash[:notice] = ["Curriculum unfavorited!"]
        redirect_to curriculum_url(curriculum_id)
      end
    end
  end
end
