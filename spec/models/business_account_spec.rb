require 'spec_helper'

describe BusinessAccount do

    it "Has a valid factory" do
        business = FactoryGirl.build(:business_account)
        expect(business).to be_valid
    end 

    it "Contains no payment" do
        business = FactoryGirl.build(:business_account)
        expect(business.payments.count).to eq(0)
    end

    context "In order to be registered" do
        let(:business) { FactoryGirl.create(:business_account, payments: [FactoryGirl.build(:payment)]) }

        it "must have a processed signup payment" do
            expect(business.payments.first.status).to eq('Pending')
            business.payments.first.complete_payment("XXXXXXX")
            expect(business.payments.first.status).to eq('Complete')
            expect(business.payments.first.confirmation).not_to eq(nil)
        end

    end

end
