require 'rails_helper'

RSpec.describe "account_admins/index", :type => :view do
  before(:each) do
    assign(:account_admins, [
      AccountAdmin.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :hashed_password => "Hashed Password"
      ),
      AccountAdmin.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :hashed_password => "Hashed Password"
      )
    ])
  end

  it "renders a list of account_admins" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Hashed Password".to_s, :count => 2
  end
end
