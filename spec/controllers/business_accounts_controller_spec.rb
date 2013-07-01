require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe BusinessAccountsController do
      Stripe.api_key = ENV['stripe_key']

  
  #This test suite uses WebMock to disable outbound HTTP Requests. Provide it with fixtures and roll on.
  before(:each) do
    @customer_response = File.open('spec/fixtures/stripe_customer_response.json').read
    @charge_response = File.open('spec/fixtures/stripe_charge_response_success.json').read
    stub_request(:post, "https://api.stripe.com/v1/charges").to_return(:status => 200, :body => @charge_response, :headers => {})
    stub_request(:post, "https://api.stripe.com/v1/customers").to_return(:status => 200, :body => @customer_response, :headers => {})
  end
  # This should return the minimal set of attributes required to create a valid
  # BusinessAccount. As you add validations to BusinessAccount, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { 
                          { "name_first" => "MyString", 
                            "name_last" => "MyString",
                            "email" => "test@test.com",
                            "address" => "1234 test st",
                            "phone" => "(555)555-5555",
                            "city" => "test",
                            "state" => "tx",
                            "zip" => "55555",
                            "type" => "test",
                            "business" => "Acme testing co",
                            "country" => "US",
                            "stripe_token" => "tok_111111111"
                         }
                       }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BusinessAccountsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "redirects to edit" do
        get :index
        response.code.should == "302"
        response.should redirect_to(new_business_account_path)
    end
    # it "assigns all business_accounts as @business_accounts" do
    #   business_account = BusinessAccount.create! valid_attributes
    #   get :index, {}, valid_session
    #   assigns(:business_accounts).should eq([business_account])
    # end
  end

  describe "GET show" do
    it "assigns the requested business_account as @business_account" do
      business_account = BusinessAccount.create! valid_attributes
      get :show, {:id => business_account.to_param}, valid_session

      assigns(:business_account).should eq(business_account)
    end
  end

  describe "GET new" do
    it "assigns a new business_account as @business_account" do
      get :new, {}, valid_session
      assigns(:business_account).should be_a_new(BusinessAccount)
    end
  end

  # describe "GET edit" do
    # it "assigns the requested business_account as @business_account" do
    #   business_account = BusinessAccount.create! valid_attributes
    #   get :edit, {:id => business_account.to_param}, valid_session
    #   assigns(:business_account).should eq(business_account)
    # end
  # end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new BusinessAccount" do
        expect {
          post :create, {:business_account => valid_attributes}, valid_session
        }.to change(BusinessAccount, :count).by(1)
      end

      it "assigns a newly created business_account as @business_account" do
        post :create, {:business_account => valid_attributes}, valid_session
        assigns(:business_account).should be_a(BusinessAccount)
        assigns(:business_account).should be_persisted
      end

      it "redirects to thankyou page" do
        post :create, {:business_account => valid_attributes}, valid_session
        response.should redirect_to(thankyou_url)
      end
    end

    describe "with invalid params" do
      
      it "assigns a newly created but unsaved business_account as @business_account" do
        # Trigger the behavior that occurs when invalid params are submitted
        BusinessAccount.any_instance.stub(:save).and_return(false)
        post :create, {:business_account => { "name_first" => "invalid value" }}, valid_session
        assigns(:business_account).should be_a_new(BusinessAccount)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        BusinessAccount.any_instance.stub(:save).and_return(false)
        post :create, {:business_account => { "name_first" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      # it "updates the requested business_account" do
      #   business_account = BusinessAccount.create! valid_attributes
      #   # Assuming there are no other business_accounts in the database, this
      #   # specifies that the BusinessAccount created on the previous line
      #   # receives the :update_attributes message with whatever params are
      #   # submitted in the request.
      #   BusinessAccount.any_instance.should_receive(:update_attributes).with({ "name_first" => "MyString" })
      #   put :update, {:id => business_account.to_param, :business_account => { "name_first" => "MyString" }}, valid_session
      # end

      it "assigns the requested business_account as @business_account" do
        business_account = BusinessAccount.create! valid_attributes
        put :update, {:id => business_account.to_param, :business_account => valid_attributes}, valid_session
        assigns(:business_account).should eq(business_account)
      end

      it "redirects to the thank you page" do
        business_account = BusinessAccount.create! valid_attributes
        put :update, {:id => business_account.to_param, :business_account => valid_attributes}, valid_session
        response.should redirect_to(business_account)
      end
    end

    describe "with invalid params" do
      it "assigns the business_account as @business_account" do
        business_account = BusinessAccount.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        BusinessAccount.any_instance.stub(:save).and_return(false)
        put :update, {:id => business_account.to_param, :business_account => { "name_first" => "invalid value" }}, valid_session
        assigns(:business_account).should eq(business_account)
      end

      it "re-renders the 'edit' template" do
        business_account = BusinessAccount.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        BusinessAccount.any_instance.stub(:save).and_return(false)
        put :update, {:id => business_account.to_param, :business_account => { "name_first" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  # describe "DELETE destroy" do
  #   it "destroys the requested business_account" do
  #     business_account = BusinessAccount.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => business_account.to_param}, valid_session
  #     }.to change(BusinessAccount, :count).by(-1)
  #   end

  #   it "redirects to the business_accounts list" do
  #     business_account = BusinessAccount.create! valid_attributes
  #     delete :destroy, {:id => business_account.to_param}, valid_session
  #     response.should redirect_to(business_accounts_url)
  #   end
  # end

end
