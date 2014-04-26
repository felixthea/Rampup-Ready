class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
    	t.string :name
    	t.string :email
    	t.integer :company_id

      t.timestamps
    end

    add_index :invites, [:email, :company_id], unique: true
  end
end
