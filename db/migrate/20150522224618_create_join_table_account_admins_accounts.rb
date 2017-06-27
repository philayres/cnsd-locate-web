class CreateJoinTableAccountAdminsAccounts < ActiveRecord::Migration
  def change
    create_join_table :account_admins, :accounts do |t|
      # t.index [:account_admin_id, :account_id]
      # t.index [:account_id, :account_admin_id]
    end
  end
end
