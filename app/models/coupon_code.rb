class CouponCode
  include Mongoid::Document
  field :code,              type: String
  field :agent,             type: String
  field :quantity,          type: Integer,   default: 1
  field :redeemed,          type: Integer,  default: 0
  field :amount,            type: Integer
  field :expiration,        type: Date,     default: 30.days.from_now


  validates_presence_of :code, :quantity, :redeemed
  validate :expired?
  validate :redeemed?


  def self.find_by_code coupon_code
   return if coupon_code.blank?
   CouponCode.where({code: /#{coupon_code}/}).last
  end

    def redeemed?
      if self.redeemed >= quantity
        errors.add(:redeemed, "No more redemptions allowed")
      end
        redeemed >= quantity
    end

    def expired?
        if Date.today >= expiration
          errors.add(:expiration, "Coupon expired")
        end
        Date.today >= expiration
    end

    def redeem
      unless expired? || redeemed?
        self.redeemed += 1
        self.save
        "Success!"
      else
        if expired?
          "Coupon Expired"
        else
          "Already Redeemed"
        end
      end
    end

    #return the inverse to make check return true if not expired, or redeemed
    def check
      !redeemed? || !expired?
    end

end
