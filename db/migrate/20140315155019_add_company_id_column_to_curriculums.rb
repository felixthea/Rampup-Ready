class AddCompanyIdColumnToCurriculums < ActiveRecord::Migration
  def change
  	add_column :curriculums, :company_id, :integer
  end
end
