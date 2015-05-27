require "rails_helper"

RSpec.describe AccountAdminsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/account_admins").to route_to("account_admins#index")
    end

    it "routes to #new" do
      expect(:get => "/account_admins/new").to route_to("account_admins#new")
    end

    it "routes to #show" do
      expect(:get => "/account_admins/1").to route_to("account_admins#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/account_admins/1/edit").to route_to("account_admins#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/account_admins").to route_to("account_admins#create")
    end

    it "routes to #update" do
      expect(:put => "/account_admins/1").to route_to("account_admins#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/account_admins/1").to route_to("account_admins#destroy", :id => "1")
    end

  end
end
