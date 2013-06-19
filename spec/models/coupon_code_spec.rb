require 'spec_helper'

describe CouponCode do

    context "To test it must" do
        it "have a valid factory" do
            expect(FactoryGirl.build :coupon_code).to be_valid
        end
    end

    context "To validate it must" do
        let(:coupon){FactoryGirl.build :coupon_code, quantity: 5, redeemed: 5, expiration: 1.day.ago}

        it "know if redeemed" do
            expect(coupon.redeemed?).to be_true
        end
        
        it "know if expired" do
            expect(coupon.expired?).to be_true
        end
    end

    context "As a" do
        context "Valid Coupon it must" do
            let(:coupon){FactoryGirl.build :coupon_code, quantity: 6, redeemed: 4, expiration: 1.day.from_now}
            
            it "Redeems and increments by one" do
                expect(coupon.redeem).to eq("Success!")
                expect(coupon.redeemed).to eq(5)
            end

            it "Validates Itself" do
                expect(coupon.check).to be_true
            end
        end

       context "Invalid Coupon it must" do

            it "reject additional redemptions if over quantity" do
                coupon = FactoryGirl.build :coupon_code, quantity: 4, redeemed: 4
                coupon.redeem
                expect(coupon.redeem).to eq("Already Redeemed")
            end
            
            it "reject redemption if expired" do
                coupon = FactoryGirl.build :coupon_code, expiration: 1.day.ago
                expect(coupon.redeem).to eq("Coupon Expired")
            end

       end 

    end

end
