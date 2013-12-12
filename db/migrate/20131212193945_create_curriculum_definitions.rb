class CreateCurriculumDefinitions < ActiveRecord::Migration
  def change
    create_table :curriculum_definitions do |t|
      t.integer :definition_id
      t.integer :curriculum_id
      t.timestamps
    end

    add_index :curriculum_definitions, :definition_id
    add_index :curriculum_definitions, :curriculum_id
    add_index :curriculum_definitions, [:definition_id, :curriculum_id], unique: true
  end
end
