module AdministratorsHelper
    
  def can_not_edit?
    @reason = @administrator.not_editable_by?(current_user)
  end
  
  def can_not_delete?
    @reason = @administrator.not_deletable_by?(current_user)        
  end
  
  def status
    return unless @administrator.status
    s = Administrator::Statuses.keys[@administrator.status]
    return t(s) if s
  end
  
end
