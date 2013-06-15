require 'spec_helper'

describe "business_accounts/show" do
  before(:each) do
    @business_account = assign(:business_account, stub_model(BusinessAccount,
      :name_first => "Name First",
      :name_last => "Name Last",
      :business => "Business",
      :email => "Email",
      :phone => "Phone",
      :address => "Address",
      :city => "City",
      :state => "State",
      :zip => "Zip",
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name First/)
    rendered.should match(/Name Last/)
    rendered.should match(/Business/)
    rendered.should match(/Email/)
    rendered.should match(/Phone/)
    rendered.should match(/Address/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Zip/)
    rendered.should match(/Type/)
  end
end
