class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , ,  and :omniauthable , :rememberable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :lockable, :timeoutable, :confirmable
       
  after_save :link_administrators
  
  has_many :administrators
  
protected

  def link_administrators    
    Administrator.pend_all_for_new_user email, id
    true
  end
  
end
