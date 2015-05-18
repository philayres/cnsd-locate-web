class Tweets
    
  attr_accessor :response
  
  def initialize
    
  end
  
  def near_here query, latitude, longitude, radius = [1, :mi, :scale], options = {}
    
    opt = {
      geocode: "#{latitude},#{longitude},#{radius[0..1].join('')}",    
    }
    
    opt.merge! options
    
    count = options[:count] || 100
    
    res = Rails.cache.fetch(opt, expires_in: 30.minutes) do
      client.search(query, opt).take(count)
    end
    
    if radius.last == :scale && res.length < 50 && radius.first < 500
      radius[0] = radius.first * 3
      res = near_here query, latitude, longitude, radius, options
    end
            
    if res
      distances = {}
      options[:distances] = distances
      res.each do |t|
        c = t['geo']['coordinates'] if t['geo']
        if c
          from = {latitude: latitude.to_f, longitude: longitude.to_f}
          to = {latitude: c[0].to_f, longitude: c[1].to_f}
          g = Geodistance.new(from, to)          
          distances[t.id.to_s] = g.distance
        end
      end
    end
    
    res
  end
  
  
protected
    def client
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = TwitterConsumerKey
        config.consumer_secret     = TwitterConsumerKeySecret
        config.access_token        = TwitterAccessToken
        config.access_token_secret = TwitterAccessTokenSecret
      end
    end
  
end