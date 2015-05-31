class AddUserIdToAdministrators < ActiveRecord::Migration
  def change
    add_reference :administrators, :user, index: true
  end
end
