class RemoveColumnHashedPwFromAccountAdmins < ActiveRecord::Migration
  def change
    remove_column :account_admins, :hashed_password
    add_column :account_admins, :hashed_password, :string, null: false
  end
end
