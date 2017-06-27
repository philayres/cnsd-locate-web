class Administrator < ActiveRecord::Base

  include ValidationPatterns
  
  belongs_to :account
  belongs_to :user
  
  validates :email, length: {in: 6..255} , format: {with: EMAIL_PATTERN}
  before_validation :fix_email
  before_create :handle_existing_user
  
  Statuses = {not_registered: nil, confirmed: 1, pending: 2, rejected: 3, removed: 4}

  def self.pend_all_for_new_user email, user_id
    
    # Set the administrator records with matching email address to:
    # status: pending 
    # user_id: the specified user_id at the point in time they were set to pending
    # > the aim is to keep a permanent link between the user account and the administrator record
    #   even if the email address should change in the future (including for any pending items)
    
    nr = user_not_registered(email)
    nr.each do |aa|
      aa.status = Statuses[:pending]
      aa.user_id = user_id
      aa.save
    end
    
    logger.info "Pend All: #{nr.length} for email #{email} and user_id #{user_id}"
    
    nr.length
    
  end
  
  def self.for_account_user account, current_user
    account.administrators.where(user_id: current_user.id).first
  end
  
  def self.user_not_registered email    
    Administrator.where(status: Statuses[:not_registered], email: email)    
  end
  
  
  
  
  def accept_invitation!
    accept_invitation
    self.save
  end
  
  def accept_invitation
    self.status = Statuses[:confirmed]
  end
  def decline_invitation!
    decline_invitation
    self.save
  end
  def decline_invitation
    self.status = Statuses[:rejected]
  end
  

  
  
  def not_deletable_by? user
    return :can_not_edit_record if not_editable_by? user
    return :can_not_delete_last_confirmed_user if account.users.length == 1
    nil
  end
  
  def not_editable_by? current_user
    if status ==  Statuses[:confirmed] && self.user.id != current_user.id
      return :only_editable_by_confirmed_user
    elsif status != Statuses[:confirmed] && !account.accessible_by?(current_user)
      return :user_not_an_administrator
    end
    
    nil
  end
  
  def accessible_by? current_user
    account.accessible_by? current_user
  end
  
  def status_as_key
    s = status || 0
    Administrator::Statuses.keys[s]
  end
  
  
  
protected
  
  def fix_email
    self.email = email.downcase #if email
  end
  
  def handle_existing_user
    user = User.where(email: email).first
    if user
      self.status = Statuses[:pending]
      self.user_id = user.id
    end
    
    true
  end
  
end
