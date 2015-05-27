class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  def requires_authentication
    logger.info "Checking authentication of #{user}"
    redirect_to '/logins/new' and return false unless user
  end
  

protected
  def set_user
    return nil unless @login
    @user = @login
        
    Rails.cache.write({user: @user.id}, @user, login_cache_options)
    
    
  end
  
private

  def user
    return nil unless @user && @user.id
    @user = Rails.cache.read({user: @user.id}, login_cache_options)
        
  end
  
  def login_cache_options
    {expires_in: 2.hours, namespace: 'cnsd-locate-web-logins'}
  end
  
end
