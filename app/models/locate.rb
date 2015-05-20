class Locate 
  
  def initialize
    
  end
  
  def get_location addr
    return nil unless addr.split('.').length == 4
    params = {addr: addr}
    Rails.logger.info "get_location for #{addr}"
    
    not_cached = true
    
    res = Rails.cache.fetch(params) do
      Rails.logger.info "Calling service for location data: not cached"
      path = '/locate/ip'
      res = requester.make_request :get, params, path

      not_cached = false
      
      if res.code == 200
        Rails.logger.info "Got a result for the location!"
        requester.data['ip'] = addr        
        requester.data
      else
        Rails.logger.info "Failed to get a result for the location. #{res.code}::#{res.body}"
        nil
      end
    end    
    
    Rails.logger.info "The result came from cache? #{!!not_cached}"
    
    res
  end
  
protected
  def requester     
   @request ||= ReSvcClient::Requester.new LocateServer, LocateClientId, LocateClientSecret
  end
  
end