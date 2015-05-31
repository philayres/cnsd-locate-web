class DropAccountAdmins < ActiveRecord::Migration
  def change
    drop_table :account_admins
    drop_table :account_admins_accounts
  end
end
