module Services
  class LocateController < ApplicationController

    def index
      addr = request.ip
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