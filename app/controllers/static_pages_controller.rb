class StaticPagesController < ApplicationController
	def index
		@new_words = Word.where('company_id = ?', current_co.id).order("words.created_at desc").first(5)
		@new_curriculums = Curriculum.where('company_id = ?', current_co.id).order("curriculums.created_at desc").first(5)
		@new_definitions
		render :index
	end
end
