class StaticPagesController < ApplicationController
	def index
		@new_words = Word.recently_added(current_co, 5)
		@new_curriculums = Curriculum.recently_added(current_co, 5)
		@new_definitions = Definition.recently_added(current_co, 3)
		@tags = Tag.where('company_id = ?', current_co.id)
		@subdivisions = Subdivision.where('company_id = ?', current_co.id)
		render :index
	end
end
