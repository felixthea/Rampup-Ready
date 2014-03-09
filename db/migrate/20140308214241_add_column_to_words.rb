class AddColumnToWords < ActiveRecord::Migration
  def change
  	add_column :words, :company_id, :integer
  end
end
