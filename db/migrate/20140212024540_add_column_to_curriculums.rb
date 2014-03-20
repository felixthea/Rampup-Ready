class AddColumnToCurriculums < ActiveRecord::Migration
  def change
  	add_column :curriculums, :private, :boolean, default: false
  end
end
