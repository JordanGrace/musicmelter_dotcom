require 'spec_helper'

describe BusinessAccount do

    it "Has a valid factory" do
        business = FactoryGirl.build(:business_account)
        expect(business).to be_valid
    end 

    it "Contains no payment" do
        business = FactoryGirl.build(:business_account)
        expect(business.payments.count).to eq(0)
        expect(business.no_payment?).to eq(true)
        expect(business.not_a_customer?).to eq(true)
        expect(business.no_really?).to eq(false)
    end

    context "In order to be registered" do
        let(:business) { FactoryGirl.create(:business_account, payments: [FactoryGirl.build(:payment, comment: "test")]) }

        it "must have a processed signup payment" do
            expect(business.payments.first.status).to eq('Pending')
            business.payments.first.complete_payment({id: "XXXXXXX",
                                                    amount: "40400",
                                                    card: { fingerprint: "1234xxx"}
                                                     })
            expect(business.payments.first.status).to eq('Complete')
        end

    end
    
    

end
