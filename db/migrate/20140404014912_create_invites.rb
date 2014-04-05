class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
    	t.string :name
    	t.string :email
    	t.integer :company_id

      t.timestamps
    end
  end
end
