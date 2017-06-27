class LoginsController < ApplicationController

  before_action :requires_authentication, only: [:destroy, :show]
  
  
  def index
    
  end
  
  def show
    respond_to do |format|
      format.html {redirect_to '/accounts/'}
      format.json {render json: json_logged_in }
    end
  end
  
  
private
  
  
  def json_logged_in
    {user_id: current_user.id}
  end
  
end
