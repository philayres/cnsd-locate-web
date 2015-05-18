require "rails_helper"
describe Tweets do
  before(:each) do
    @twitter = Tweets.new
  end

  it "should test Twitter can make a search request for nearby tweets and iterate through 
      larger radius searches until it gets at least 50 tweets" do
    
    res = @twitter.near_here("", "41.8734", "-70.6394")
    
    expect(res).to be_a Array
    expect(res.length).to be >= 50
  end
  
end

