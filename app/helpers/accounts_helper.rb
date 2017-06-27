module AccountsHelper
  
  def admin_status account
    admin = Administrator.for_account_user(account, current_user)
    
    
    return unless admin && admin.status
    s = admin.status_as_key
    res =  t(s) if s
    
    if s == :pending
      res = "<span data-show-popover=\"auto\" data-toggle=\"popover\" data-content=\"Accept or reject your invitation to administer this application\">#{link_to res, edit_account_path(account)}</span>" 
    elsif s == :confirmed
      res  = "Active"
    end
    
    res.html_safe
  end
  
end
