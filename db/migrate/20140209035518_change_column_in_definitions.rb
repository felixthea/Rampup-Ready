class ChangeColumnInDefinitions < ActiveRecord::Migration
  def up
  	change_column :definitions, :body, :text
  end

  def down
  	change_column :definitions, :body, :string
  end
end
