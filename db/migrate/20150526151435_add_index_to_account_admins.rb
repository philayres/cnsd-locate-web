class AddIndexToAccountAdmins < ActiveRecord::Migration
  def change
    remove_index :account_admins, :email
    add_index :account_admins, :email, unique: true
  end
end
