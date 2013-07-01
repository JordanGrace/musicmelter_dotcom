
require 'spec_helper'

describe CouponController do

  describe "GET 'validate'" do
  	context "successful request" do
  		before(:each) do
  			CouponCode.stub(:find_by_code).and_return(FactoryGirl.build :coupon_code, code: "UnitTest")
  		end
	    it "returns http success" do
	      get 'validate', { :coupon_code => 'UnitTest'}, :format => :json
	      response.should be_success
	      response.body.should_not be_nil
	    end

	end

	context "Unsuccessful request" do

	    it "returns 404 if no coupon found" do
	    	get 'validate', { :coupon_code => 'NotGonnaFindMe'}, :format => :json
	    	response.should_not be_success
	    	response.code.should eq("404")
	    end

	    it "renders nothing without a coupon code" do
	    	get 'validate', { :coupon_code => nil}
	    	response.should_not be_success
	    end

	end


  end

end
