class AddCompanyIdColumnToDefinitions < ActiveRecord::Migration
  def change
  	add_column :definitions, :company_id, :integer
  end
end
