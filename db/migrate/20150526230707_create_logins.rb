class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.string :user_id
      t.references :account_admin, index: true
      t.string :from_ip

      t.timestamps
    end
  end
end
