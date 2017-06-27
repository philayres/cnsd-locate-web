require 'rails_helper'

RSpec.describe "accounts/edit", :type => :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :owner_name => "MyString"
    ))
  end

  it "renders the edit account form" do
    render

    assert_select "form[action=?][method=?]", account_path(@account), "post" do

      assert_select "input#account_owner_name[name=?]", "account[owner_name]"
    end
  end
end
