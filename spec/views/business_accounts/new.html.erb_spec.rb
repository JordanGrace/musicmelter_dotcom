require 'spec_helper'

describe "business_accounts/new" do
  before(:each) do
    assign(:business_account, stub_model(BusinessAccount,
      :name_first => "MyString",
      :name_last => "MyString",
      :business => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :address => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString",
      :type => ""
    ).as_new_record)
  end

  it "renders new business_account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", business_accounts_path, "post" do
      assert_select "input#business_account_name_first[name=?]", "business_account[name_first]"
      assert_select "input#business_account_name_last[name=?]", "business_account[name_last]"
      assert_select "input#business_account_business[name=?]", "business_account[business]"
      assert_select "input#business_account_email[name=?]", "business_account[email]"
      assert_select "input#business_account_phone[name=?]", "business_account[phone]"
      assert_select "input#business_account_address[name=?]", "business_account[address]"
      assert_select "input#business_account_city[name=?]", "business_account[city]"
      assert_select "input#business_account_state[name=?]", "business_account[state]"
      assert_select "input#business_account_zip[name=?]", "business_account[zip]"
      assert_select "input#business_account_type[name=?]", "business_account[type]"
    end
  end
end
