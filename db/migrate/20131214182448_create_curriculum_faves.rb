class CreateCurriculumFaves < ActiveRecord::Migration
  def change
    create_table :curriculum_faves do |t|
      t.integer :curriculum_id
      t.integer :user_id
      t.timestamps
    end
    
    add_index :curriculum_faves, :curriculum_id
    add_index :curriculum_faves, :user_id
    add_index :curriculum_faves, [:curriculum_id, :user_id], unique: true
  end
end
