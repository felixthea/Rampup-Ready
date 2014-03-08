class AddColumnToSubdivision < ActiveRecord::Migration
  def change
  	add_column :subdivisions, :company_id, :integer
  end
end
