class StaticPagesController < ApplicationController
	def index
		@new_words = Word.where('company_id = ?', current_co.id).order("words.created_at desc").first(5)
		@new_curriculums = Curriculum.where('user_id = ?', current_user.id).order("curriculums.created_at desc").first(5)
		# new curriculums is wrong.  needs to also grab the public curriculums and not just the ones that belong to the user
		@new_definitions
		render :index
	end
end
