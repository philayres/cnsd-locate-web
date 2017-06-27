require 'rails_helper'

RSpec.describe "AccountAdmins", :type => :request do
  describe "GET /account_admins" do
    it "works! (now write some real specs)" do
      get account_admins_path
      expect(response.status).to be(200)
    end
  end
end
