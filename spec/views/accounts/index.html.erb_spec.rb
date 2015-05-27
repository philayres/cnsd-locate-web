require 'rails_helper'

RSpec.describe "accounts/index", :type => :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        :owner_name => "Owner Name"
      ),
      Account.create!(
        :owner_name => "Owner Name"
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", :text => "Owner Name".to_s, :count => 2
  end
end
