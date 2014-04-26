class AddSignupStatusToInvites < ActiveRecord::Migration
  def change
  	add_column :invites, :sign_up_status, :boolean, :default => false
  end
end
