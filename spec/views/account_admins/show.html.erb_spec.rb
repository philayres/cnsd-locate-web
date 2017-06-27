require 'rails_helper'

RSpec.describe "account_admins/show", :type => :view do
  before(:each) do
    @account_admin = assign(:account_admin, Administrator.create!(
      :first_name => "First Name",
      :last_name => "Last Name",
      :email => "Email",
      :hashed_password => "Hashed Password"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Hashed Password/)
  end
end
