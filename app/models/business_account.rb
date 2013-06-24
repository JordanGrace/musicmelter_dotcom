class BusinessAccount
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :name_first,        :type => String
  field :name_last,         :type => String
  field :business,          :type => String
  field :email,             :type => String
  #field :phone,            :type => String
  field :address,           :type => String
  field :city,              :type => String
  field :type,              :type => String
  field :country,           :type => String

  #US Fields
  field :state,             :type => String
  field :zip,               :type => String
  
  #Canadian Fields
  field :province,          :type => String
  field :postal,            :type => String
  field :special,           :type => Array

  #Payment Info
  field :customer_id,       :type => String
  field :redeemed_coupons,  :type => Array, :default => []
  field :subscription,      :type => String
  field :last4,             :type => Integer

  #single use token - updateable
  field :stripe_token,      :type => String

  validates_presence_of :name_first, :name_last, :business, :email, :country, :stripe_token
  #validates_presence_of :address, :city, :state, :zip, 

  attr_accessor :valid_types, :coupon_code
  
  #Validator(?) Doesnt seem intuitive.
  @valid_types = ["Recording Studio", "Rehearsal Studio", "Mix/Mastering Studio",
                   "Show/Concert Venue", "Vocal Coach", "Music Instructor", 
                   "Music School", "Wholesaler", "Producer", "DJ Services", "Other"]

  #TODO: Validate Canadian Zip based on country of origin
  #validates_format_of :zip, with: '\b[ABCEGHJKLMNPRSTVXY][0-9][A-Z] [0-9][A-Z][0-9]\b' 

  embeds_many :payments

  accepts_nested_attributes_for :payments
  before_save :update_stripe


  def no_payment?
    self.payments.count == 0 || self.payments.nil?
  end

  def not_a_customer?
    self.customer_id.blank?
  end

  #public method to interface with stripe, and create customer data
  # in their API. Since v1.3
  def update_stripe
    #todo: uncomment when ready to deploy
    #return if email.include?('@test.com') #and not Rails.env.production?
    if not_a_customer?
      self.customer_id = create_stripe_customer
    end
  end

  #`Purchase`: 
  # param amount: Integer - amount in pennies to charge the customer
  # param description: String - Comment for the payment
  # param payment_id : String - Serialized token of a stripe card
  # param coupon_code: String - The distributable description of the coupon.
  # example usage: @business_account.purchase(600, "test purchase", "tok_121212121", "CheapSkate")
  def purchase(amount, description, payment_id, coupon_code = self.coupon_code)
   raise "No Payment Method" if self.customer_id.blank? && self.stripe_token.blank?

    coupon = CouponCode.find_by_code(coupon_code)
    unless coupon.blank?
      amount = process_coupon(coupon, amount)
    end

    #Calculate HST tax for Canadian registrants
    if self.country == 'CA'
      hst_tax = amount * 0.13
      amount += hst_tax
    end

    charge = self.payments.create(amount: amount, comment: description, stripe_token: payment_id)
    charge.process
    charge.save
    self.save

    #kick off the receipt email
    StripePayment.business_account_registration_receipt(self).deliver
  end


  private  
  def create_stripe_customer
    raise "No Payment Information" if stripe_token.blank?
    info = { 
      email: email, 
      description: name_first << " " << name_last, 
      card: stripe_token
    }
      customer = Stripe::Customer.create( info )
      customer.save 
      customer.id 

  
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "#{e.message}."
      self.stripe_token = nil
  end

  def process_coupon(coupon, amount)
    return if amount.blank?

    if coupon.redeem != "Success!"
      amount
    end 

    amount = amount - coupon.amount
    self.redeemed_coupons.push(coupon.id)
    amount
  end

end