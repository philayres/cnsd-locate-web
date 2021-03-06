require 'rails_helper'

RSpec.describe "account_admins/edit", :type => :view do
  before(:each) do
    @account_admin = assign(:account_admin, Administrator.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :hashed_password => "MyString"
    ))
  end

  it "renders the edit account_admin form" do
    render

    assert_select "form[action=?][method=?]", account_admin_path(@account_admin), "post" do

      assert_select "input#account_admin_first_name[name=?]", "account_admin[first_name]"

      assert_select "input#account_admin_last_name[name=?]", "account_admin[last_name]"

      assert_select "input#account_admin_email[name=?]", "account_admin[email]"

      assert_select "input#account_admin_hashed_password[name=?]", "account_admin[hashed_password]"
    end
  end
end
