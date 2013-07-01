require 'spec_helper'

describe BusinessAccount do
    Stripe.api_key = ENV['stripe_key']

    context "To test it must" do
        it "Have a valid factory" do   
            expect(FactoryGirl.build :business_account ).to be_valid
        end 
    end

    context "To integrate with stripe it must" do
        before(:each) do
            @stripe_customer = File.open("spec/fixtures/stripe_customer_response.json").read
        end
        let(:business) { FactoryGirl.build(:business_account,
                                            name_first: 'Stephen',
                                            name_last: 'Colbert',
                                            email: 'stephen@colbertshow.com',
                                            business: 'The Colbert Show',
                                            country: 'US',
                                            customer_id: nil,
                                            payments: [],
                                            stripe_token: 'tok_111111111111') 
                        }

        context "interface with the customer api to" do
            it "Create a basic record" do

         stub_request(:post, "https://api.stripe.com/v1/customers").to_return(:status => 200, :body => @stripe_customer, :headers => {})

                business.update_stripe
                expect(business.customer_id).to_not be_nil
                expect(business.customer_id).to eq("cus_23mZ8azcOCXNQh")
                
            end

            # todo: Doesn't have an available fake stripe_token for use
            # it "create a record with payment info" do
            #     business.stripe_token = 
        
        end

         
        context "process payments and" do
            before(:each) do
                @successful_stripe_charge = File.open("spec/fixtures/stripe_charge_response_success.json").read
                @failed_stripe_charge = File.open("spec/fixtures/stripe_charge_response_failure.json").read
            end
            let (:business) { FactoryGirl.create(:business_account, 
                                                customer_id: "cus_22H0h7WCDUao6S", 
                                                payments: [], 
                                                redeemed_coupons: []) 
                            }

            it "create a stripe charge" do

               stub_request(:post, "https://api.stripe.com/v1/charges").to_return(:status => 200, :body => @successful_stripe_charge, :headers => {})

                business.purchase(600, "Testing purchase", "tok_229DddqhXKbEqc", "unit_test")
                expect(business.payments.count).to eq(1)
                expect(business.payments[0][:status]).to eq("Complete")
                expect(business.payments[0][:fingerprint]).to eq("XZ12pjL0OW1bJJV1")

            end

            it "identify failed stripe charges" do

                stub_request(:post, "https://api.stripe.com/v1/charges").to_return(:status => 200, :body => @failed_stripe_charge, :headers => {})

                business.purchase(600, "Failed test purchase", "fail", "unit_test")
                expect(business.payments.count).to eq(1)
                expect(business.payments[0][:status]).to eq("Failed")
            end


            it "reject charges when no payment info is available" do
                expect{ business.purchase(600,nil,nil,nil)}.to raise_error
            end

            context "interact with coupons by" do
                
                before(:each) do
                    coupon = double("CouponCode")
                    coupon.should_receive(:redeem)
                    coupon.should_receive(:amount).and_return(1)
                    coupon.should_receive(:id).and_return(1234)
                    coupon.stub(:new).and_return({id: 1234,  agent: "Cyril Figgis", code: "ArcherSucks", amount:1, expiration: 30.days.from_now, quantity: 1, redeemed: 0})
                   CouponCode.stub(:find_by_code).and_return( coupon )
                    @successful_stripe_charge = File.open("spec/fixtures/stripe_charge_response_success.json").read
                end

                it "reduces payment amount when coupon is valid" do
                          stub_request(:post, "https://api.stripe.com/v1/charges").to_return(:status => 200, :body => @successful_stripe_charge, :headers => {})

                    business.purchase(600, "testing coupon purchase", "tok_111111111111", "ArcherSucks")
                    expect(business.payments.count).to eq(1)
                    expect(business.redeemed_coupons.count).to eq(1)
                    expect(business.redeemed_coupons.last).to eq(1234)
                    expect(business.payments[0].amount).to eq(599)
                end

            #     it "halting payment on invalid coupon code" 
            end


         end
    
    end
    
end
