require 'spec_helper'

describe Payment do
    Stripe.api_key = ENV['stripe_key']

    let(:payment) { FactoryGirl.build(:payment) }

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

    context "It can" do
        before(:each) do
            stripe = double("Stripe::Charge")
            stripe.should_receive(:create)
            stripe.stub(:create).and_return()
        end
        
    end

end
