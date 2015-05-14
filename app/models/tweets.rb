class Tweets
  
  AccessToken ='76816072-zwEa6H3yUZX8k5RxchL8ldi5PzBPCcRVCasqFQHm0'
  AccessTokenSecret = 'BEgasLfs2usyWUuTmixIyd0qJ96heE1TmwUuQVbjz0rOm'
  ConsumerKey = '4UhCiVNZfyD4KAPhcdeCgtAUd'
  ConsumerKeySecret = 'RCcUV3ZgrupVLH6Wv6HsGDYKRVy0ztJWlL4YHDjby1oCHJDieO'
  
  attr_accessor :response
  
  def initialize
    
  end
  
  def near_here query, latitude, longitude, radius = [5, :mi], count=100, options = {}
    
    opt = {
      geocode: "#{latitude},#{longitude},#{radius.join('')}",    
    }
    
    opt.merge! options
    
    Rails.cache.fetch(opt, expires_in: 15.minutes) do
      client.search(query, opt).take(count)
    end
    
  end
  
  
protected
    def client
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ConsumerKey
        config.consumer_secret     = ConsumerKeySecret
        config.access_token        = AccessToken
        config.access_token_secret = AccessTokenSecret
      end
    end
  
end