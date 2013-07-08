require 'spec_helper'

describe Payment do
    Stripe.api_key = ENV['stripe_key']

    let(:payment) { FactoryGirl.build(:payment) }
    before(:each) do
	
        #stub_request(:post, "https://api.stripe.com/v1/customers").
         #with(:body => {"card"=>"tok_111111111", "description"=>"MyString MyString", "email"=>"test@test.com"}).
         #to_return(:status => 200, :body => "", :headers => {})
     end

    context "To validate it must " do
        it "have a comment" do
            expect(payment.comment).not_to eq(nil)
            expect(payment.comment).to eq("Signup")
        end
        it "have a status" do
            expect(payment.status).not_to eq(nil)
            expect(payment.status).to eq("Pending")
        end
    end

  context "creates charges" do
	before(:each) do
		@paypal_redirect = File.open("spec/fixtures/paypal_setexpresscheckout_response.json").read
		stub_request(:post, "https://api-3t.sandbox.paypal.com/nvp").
		to_return(:status => 200, :body => @paypal_redirect, :headers => {})

	end
  
	  let(:payment) { FactoryGirl.build(:payment, paypal_token: true, amount: 600) }

	it "to paypal" do
		expect(payment.process).to_not be_nil
	end	

  end


end
