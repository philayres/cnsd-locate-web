module AccountAccess
  extend ActiveSupport::Concern
    
  def set_account      
    @account = nil
    @administrator = nil
    @user_status = nil
    id = params[:account_id] 
    id = params[:id]  if id.blank?
    a = Account.find(id)
    if a.accessible_by?(current_user)
      @account = a 
      @administrator = Administrator.for_account_user(@account, current_user) if @account
      @user_status = @administrator.status_as_key if @administrator      
    else
      redirect_to accounts_path, notice: 'You are not authorized to access this application'
      return
    end
    
    
    @account
  end
    
end
