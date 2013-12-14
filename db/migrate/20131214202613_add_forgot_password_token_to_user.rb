class AddForgotPasswordTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :forgot_password_token, :string
    add_index :users, :forgot_password_token
  end
end
