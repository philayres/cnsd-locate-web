require "rails_helper"

describe Services::TweetsController do
  it "should get some tweets" do
    get :index, lat: "41.8734", lng: "-70.6394"
    expect(response).to be_success
    expect(page).to be_a String
  end
      
end

