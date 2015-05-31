class Account < ActiveRecord::Base
  
  has_many :administrators

 # accepts_nested_attributes_for :administrators
  
  Statuses = {disabled: 0, active: 1, onhold: 2}
  
  def self.all_for_user current_user    
    Account.joins(:administrators).where('administrators.user_id' => current_user.id).order('administrators.status')    
  end
  
  def accessible_by? current_user 
    a = administrators.where('administrators.user_id' => current_user.id).first
    return false unless a
    return true if [:confirmed, :pending].include?(a.status_as_key)
    
    false
  end
  
    
  def make_current_user_admin current_user
    aa = administrators.build
    aa.first_name = 'Current'
    aa.last_name = 'User'
    aa.email = current_user.email
    aa.user_id = current_user.id
    aa.accept_invitation
  end
  
  
  def disable!
    self.status = Statuses[:disabled]
    save
  end

  def users
    self.administrators.select {|a| a.user }
  end
  
protected

  
end
