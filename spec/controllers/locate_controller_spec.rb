require "rails_helper"

describe Services::LocateController do
  it "should get a location for a valid IP address" do
    get :show, id: '50-138-223-72'
    expect(response).to be_success
    expect(response.body).to be_a String
    
    data = JSON.parse response.body    
    expect(data['postal_code']).to be_a String
    expect(data['postal_code'].length).to be 5
  end
  
  it "should get a location for hosts current IP address" do
    @request.env['REMOTE_ADDR'] = '50.138.223.53'
    get :index 
    expect(response).to be_success
    expect(response.body).to be_a String
    
    data = JSON.parse response.body    
    expect(data['postal_code']).to be_a String
    expect(data['postal_code'].length).to be 5
  end
      
end

