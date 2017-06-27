class CreateAccountAdmins < ActiveRecord::Migration
  def change
    create_table :account_admins do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :hashed_password

      t.timestamps
    end
    add_index :account_admins, :email
  end
end
