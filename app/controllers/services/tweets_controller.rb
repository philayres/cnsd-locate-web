module Services
  class TweetsController < ApplicationController

    def index
      lat = params[:lat]
      lng = params[:lng]

      bad_request = false

      bad_request = true if lat.blank?
      bad_request = true if lng.blank?

      render status: 400, json: {code: "BAD_LAT_LNG"}  and return if bad_request

      radius = [1, :mi, :scale]
      
      options = {count: 100}
      @tweets = Tweets.new.near_here("", lat, lng, radius, options)
      
      render json: {tweets: @tweets, results: {radius: radius, count: @tweets.length, distances: options[:distances]}}
    end

  end
end