class AddColumnStatusToAccounts < ActiveRecord::Migration
  def change    
    add_column :accounts, :status, :integer, default: 1
  end
end
