class Locate 
  
  def initialize
    
  end
  
  def get_location addr
    return nil unless addr.split('.').length == 4
    params = {addr: addr}
    Rails.cache.fetch(params) do
      Rails.logger.info "Calling service for location data: not cached"
      path = '/locate/ip'
      res = requester.make_request :get, params, path

      if res.code == 200
        requester.data['ip'] = addr
        requester.data
      else
        nil
      end
    end    
    
  end
  
protected
  def requester     
   @request ||= ReSvcClient::Requester.new LocateServer, LocateClientId, LocateClientSecret
  end
  
end