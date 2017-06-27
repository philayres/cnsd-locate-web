module Services
  class LocateController < ApplicationController

    def index
      addr = request.ip
      
      if Rails.env.development?
        if addr.index '127.0.0.' 
          addr = '50.138.223.53'
        end
      end
      
      logger.info "Request from #{addr}"
      
      do_locate addr
    end    

    def show
      addr = params[:id].gsub('-', '.')
      logger.info "Request from #{addr}"
      
      do_locate addr
    end    
    
  protected
  
    def do_locate addr
      
      #iptest = IPAddr.new(addr) rescue nil
      #render code: 400, json: {message: "Bad IP address for request", code: 'BAD_IP'} and return unless iptest
      
      l = Locate.new 
      res = l.get_location addr
      
      if res                        
        render json: res
      else
        render code: 404, json: {message: "Result not found", code: 'NOT_FOUND'}
      end      
    end
    
  end
end