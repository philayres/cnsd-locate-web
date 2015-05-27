class LoginsController < ApplicationController

  before_action :requires_authentication, only: [:destroy, :show]
  before_action :set_account, only: [:destroy, :show]
  
  def new
    @login = Login.new
  end

  def create
        
    @login = Login.new login_params
    
    if @login.save
      
      set_user
      set_account
      respond_to do |format|
        format.html {redirect_to '/accounts/'}
        format.json json: json_logged_in
      end
    else
    end
    
  end

  def show
    respond_to do |format|
      format.html {redirect_to '/accounts/'}
      format.json {render json: json_logged_in }
    end
  end
  
  def destroy
  end
  
private

  def set_account    
    @account_admin = @user.account_admin_id
  end
  
  def login_params
    params.require(:login).permit(:user_id, :password)
  end
  
  def json_logged_in
    {account_admin_id: @account_admin.id}
  end
  
end
