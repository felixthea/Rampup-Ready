class CreateDefinitionFaves < ActiveRecord::Migration
  def change
    create_table :definition_faves do |t|
      t.integer :definition_id
      t.integer :user_id
      t.timestamps
    end
    
    add_index :definition_faves, :definition_id
    add_index :definition_faves, :user_id
    add_index :definition_faves, [:definition_id, :user_id], unique: true
  end
end
