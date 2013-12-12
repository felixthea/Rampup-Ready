class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :vote
      t.integer :definition_id
      t.integer :user_id
      t.timestamps
    end

    add_index :votes, :definition_id
    add_index :votes, :user_id
    add_index :votes, [:definition_id, :user_id], unique: true
  end
end
