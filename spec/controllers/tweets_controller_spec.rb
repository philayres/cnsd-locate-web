require "rails_helper"

describe Services::TweetsController do
  it "should get some tweets and return some tweet data that matches the reported number of tweets" do
    get :index, lat: "41.8734", lng: "-70.6394"
    expect(response).to be_success
    expect(response.body).to be_a String
    
    data = JSON.parse response.body    
    expect(data).to have_key 'tweets'
    
    tlen = data['tweets'].length
    expect(data['results']['count']).to eq tlen
    
    # Make sure a tweet has a screen name, indicating that this is a real tweet
    expect(data['tweets'][(tlen/3).to_i]['user']['screen_name'].length).to be > 0
    
  end
      
end

