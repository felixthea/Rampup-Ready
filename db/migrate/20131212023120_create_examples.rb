class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.string :body, null: false
      t.integer :definition_id, null: false
      t.timestamps
    end
    
    add_index :examples, :definition_id
  end
end
