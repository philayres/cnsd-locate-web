class RemoveColumnPwFromAccountAdmins < ActiveRecord::Migration
  def change
    remove_column :account_admins, :password, :string
    add_column :account_admins, :password_digest, :string, null: false
  end
end
