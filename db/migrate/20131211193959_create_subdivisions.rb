class CreateSubdivisions < ActiveRecord::Migration
  def change
    create_table :subdivisions do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
