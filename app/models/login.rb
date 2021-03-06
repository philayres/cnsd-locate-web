class Login < ActiveRecord::Base
  belongs_to :administrator
  
  attr_accessor :password
  
  validates :user_id, :password, presence: true
  
  validate :login_correct
  
  
protected
  
  def login_correct
        
    a = Administrator.where(email: user_id, password: password).take(1)
    
    errors.add(:username, 'incorrect username or password') unless a.length == 1
    a  
  end
  

  
  
end
