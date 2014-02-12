class ChangeColumnNameInCurriculums < ActiveRecord::Migration
  def change
  	rename_column :curriculums, :private, :make_private
  end
end
