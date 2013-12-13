class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject, null: false
      t.string :body, null: false
      t.boolean :read, default: false
      t.integer :sender_id
      t.integer :recipient_id
      t.timestamps
    end

    add_index :messages, :sender_id
    add_index :messages, :recipient_id
  end
end
