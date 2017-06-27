class AddStatusToAdministrators < ActiveRecord::Migration
  def change
    add_column :administrators, :status, :integer
  end
end
