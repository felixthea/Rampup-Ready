class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id, null: false
      t.integer :definition_id, null: false

      t.timestamps
    end

    add_index :taggings, :tag_id
    add_index :taggings, :definition_id
    add_index :taggings, [:tag_id, :definition_id], unique: true
  end
end
