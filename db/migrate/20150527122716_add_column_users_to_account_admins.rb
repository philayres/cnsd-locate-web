class AddColumnUsersToAccountAdmins < ActiveRecord::Migration
  def change
    add_reference :account_admins, :user, index: true
    add_column :account_admins, :status, :integer
  end
end
