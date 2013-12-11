class CreateSubdivisionManagements < ActiveRecord::Migration
  def change
    create_table :subdivision_managements do |t|
      t.integer :user_id, null: false
      t.integer :subdivision_id, null: false
      t.timestamps
    end

    add_index :subdivision_managements, :user_id
    add_index :subdivision_managements, :subdivision_id
  end
end
