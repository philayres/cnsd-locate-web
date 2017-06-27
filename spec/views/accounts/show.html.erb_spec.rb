require 'rails_helper'

RSpec.describe "accounts/show", :type => :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :owner_name => "Owner Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Owner Name/)
  end
end
