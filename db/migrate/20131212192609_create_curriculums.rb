class CreateCurriculums < ActiveRecord::Migration
  def change
    create_table :curriculums do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.integer :curriculum_definition_id
      t.string :description, null: false
      t.timestamps
    end

    add_index :curriculums, :user_id
    add_index :curriculums, :curriculum_definition_id

  end
end
