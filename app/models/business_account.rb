class BusinessAccount
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :name_first,      :type => String
  field :name_last,       :type => String
  field :business,        :type => String
  field :email,           :type => String
  #field :phone,          :type => String
  field :address,         :type => String
  field :city,            :type => String
  field :state,           :type => String
  field :zip,             :type => String
  field :type,            :type => String
  field :customer_id,     :type => String
  field :coupon_code,     :type => String
  field :coupon_redeem,   :type => Boolean
  field :subscription,    :type => String
  field :last4,           :type => Integer

  validates_presence_of :name_first, :name_last, :business, :email
  validates_presence_of :address, :city, :state, :zip, :type

  attr_accessor :valid_types, :discount_amount, :stripe_token
  @valid_types = ["Recording Studio", "Rehearsal Studio", "Mix/Mastering Studio",
                   "Show/Concert Venue", "Vocal Coach", "Music Instructor", 
                   "Music School", "Wholesaler", "Producer", "DJ Services", "Other"]

  #TODO: Validate Canadian Zip based on country of origin
  #validates_format_of :zip, with: '\b[ABCEGHJKLMNPRSTVXY][0-9][A-Z] [0-9][A-Z][0-9]\b' 

  embeds_many :payments



  def valid_coupon?
    return if coupon_redeem 
    coupon =  Stripe::Coupon.retrieve(coupon_code)
    #all amounts are in denomination of pennies
    self.discount_amount = coupon.amount_off / 100    
    coupon.max_redemptions >= coupon.times_redeemed
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      false
  end

  def update_stripe
    #return if email.include?('@test.com') #and not Rails.env.production?
      if customer_id.blank? && stripe_token.present?
        customer = Stripe::Customer.create(
                                            email: email,
                                            card: stripe_token,
                                            description: name_first << name_last,
                                            )
        if valid_coupon?
          customer.coupon = coupon_code
          coupon_redeem = true
        end
        customer.save
        self.last4 = customer.active_card.last4
        self.customer_id = customer.id
        self.stripe_token = nil
        self.save
      end


  
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    self.stripe_token = nil
    false
  end
  

  def process_payment(payment = {})
    self.stripe_token = payment.stripe_token
    update_stripe
  end

    def stripe_customer
      Stripe::Customer.retrieve(customer_id)
    end

    def old_payment?
      if self.payments.nil?
        return false
      end
      self.payments.last.created_at >= 1.year.ago
    end

    def no_payment?
      self.payments.count == 0 || self.payments.nil?
    end

    def not_a_customer?
      self.customer_id.nil?
    end

    def no_really?
      self.payments.count > 0 && self.payments.last.status == "Complete" && self.customer_id != nil  
    end
end
