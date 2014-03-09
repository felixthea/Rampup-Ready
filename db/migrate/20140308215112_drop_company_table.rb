class DropCompanyTable < ActiveRecord::Migration
  def up
  	drop_table :companies if ActiveRecord::Base.connection.table_exists? 'companies'
  end

  def down
  	create_table :companies do |t|
  		t.string :name

  		t.timestamps
  	end
  end
end
