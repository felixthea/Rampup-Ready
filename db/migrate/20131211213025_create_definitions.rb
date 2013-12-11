class CreateDefinitions < ActiveRecord::Migration
  def change
    create_table :definitions do |t|
      t.integer :word_id, null: false
      t.integer :user_id, null: false
      t.string :body, null: false
      t.integer :subdivision_id, null: false

      t.timestamps
    end

    add_index :definitions, :word_id
    add_index :definitions, :user_id
    add_index :definitions, :subdivision_id
  end
end
