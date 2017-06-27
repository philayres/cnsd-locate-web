require 'rails_helper'

RSpec.describe "accounts/new", :type => :view do
  before(:each) do
    assign(:account, Account.new(
      :owner_name => "MyString"
    ))
  end

  it "renders new account form" do
    render

    assert_select "form[action=?][method=?]", accounts_path, "post" do

      assert_select "input#account_owner_name[name=?]", "account[owner_name]"
    end
  end
end
