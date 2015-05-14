module Services
  class TweetsController < ApplicationController

    def index
      lat = params[:lat]
      lng = params[:lng]

      bad_request = false

      bad_request = true if lat.blank?
      bad_request = true if lng.blank?

      render status: 400, json: {code: "BAD_LAT_LNG"}  and return if bad_request

      @tweets = Tweets.new.near_here("", lat, lng)
      
      render json: {tweets: @tweets}
    end

  end
end