class AddSignUpTokenColumnToCompaniesTable < ActiveRecord::Migration
  def change
  	add_column :companies, :signup_token, :string
  end
end
