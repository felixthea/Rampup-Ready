class StaticPagesController < ApplicationController
	def index
		@new_words = Word.where('company_id = ?', current_co.id).order("words.created_at desc").first(5)
		@new_curriculums = Curriculum.where('company_id = ?', current_co.id).order("curriculums.created_at desc").first(5)
		@new_definitions = Definition.where('company_id = ?', current_co.id).order("definitions.created_at desc").first(3)
		render :index
	end
end
