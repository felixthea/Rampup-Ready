class ChangeColumnTypeInExamples < ActiveRecord::Migration
  def up
  	change_column :examples, :body, :text
  end

  def down
  	change_column :examples, :body, :string
  end
end
