class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.belongs_to :account, index: true

      t.timestamps
    end
  end
end
