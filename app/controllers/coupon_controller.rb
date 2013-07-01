class CouponController < ApplicationController
	before_filter :check_coupon, :only => :validate


  def validate
  	coupon = CouponCode.find_by_code(params[:coupon_code])
   	
   	if coupon.blank? 
   		render json: { 'error' => "Unable to locate coupon" }, :status => 404
   		return
   	end
  		if coupon.check
  			render json: coupon, :status => 200
  		else
  			render json: coupon, :status => 422
  		end
  	
  end


  def check_coupon
    render :nothing => true, :status => 406 unless params[:coupon_code].present?
  end

end
