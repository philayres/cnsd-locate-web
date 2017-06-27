class RemoveColumnHashedPw2FromAccountAdmins < ActiveRecord::Migration
  def change
    remove_column :account_admins, :hashed_password, :string
    add_column :account_admins, :password, :string, null: false
  end
end
