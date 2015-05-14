class PagesController < ApplicationController
  
  def services

    render :services
  end
  
  def privacy
    @layout='wide'
    @description = 'Consected Privacy Policy. Clear, concise and transparent.'
    @title = 'Consected Privacy Policy'
    render :privacy
  end  
  
  def contact
    @layout=''
    @description = 'Contact Consected for more information about how we can help your business.'
    @title = 'Contact Consected'
    render :contact
  end  

  def web_services
    @layout='wide'
    @description = 'Consected Web Services. What we do online'
    @title = 'Consected Web Services'
  end
  
  def index
    @layout='wide'
    @title = 'Consected: Feel Good About Your Business'
    @description = 'Since 2009, Consected has been helping companies and non-profits understand how processes and technology can help them work better.'    
    @use_google_maps = true
    render :index
  end  
end
