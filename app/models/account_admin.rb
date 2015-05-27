class AccountAdmin < ActiveRecord::Base

  include ValidationPatterns
  
  has_and_belongs_to_many :accounts
  
  validates :email, length: {in: 6..255} , format: {with: EMAIL_PATTERN}
  #validates_uniqueness_of :email, scope: :account
  has_secure_password
  before_validation :fix_email
  
  
  
protected
  
  def fix_email
    self.email = email.downcase #if email
  end
  
  
end
