class RemoveColumnPwdFromAccountAdmins < ActiveRecord::Migration
  def change
    remove_column :account_admins, :password_digest, :string
  end
end
