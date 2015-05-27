class Account < ActiveRecord::Base
  
  has_and_belongs_to_many :account_admins
  accepts_nested_attributes_for :account_admins
  
  
  Statuses = {disabled: 0, active: 1, onhold: 2}
  
  def disable
    self.status = Statuses[:disabled]
    save
  end
    
end
