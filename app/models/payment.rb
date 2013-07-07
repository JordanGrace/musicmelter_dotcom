class Payment
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :status,         type: String,     default: 'active'
  field :comment,        type: String
  field :confirmation,   type: String
  field :charge_id,      type: String
  field :amount,         type: Integer
  field :recorded_amount,type: Integer
  field :fingerprint,    type: String
  field :coupon_id,      type: String
  attr_accessor :stripe_token, :paypal_token

  belongs_to :business_account
  embedded_in :business_account, inverse_of: :payments

  validates_presence_of :status, :comment

  # Stripe is the only provider so far, they have
  # confirmation ids - every payment must be 
  # stamped with a stripe ID to complete the payment
  def process 
    raise "No Payment Method" if self.stripe_token.blank? && self.paypal_token.blank?

    if self.stripe_token.present?
	charge_stripe
    elseif self.paypal_token.present?
    	charge_paypal
    end
    
end



private
def charge_stripe
    
    #stripe works in pennies
    charge_amount = self.amount * 100

    charge = stripe::charge.create({amount: charge_amount, 
				    customer: self.stripe_token,
				    description: self.comment,
				    currency: "usd"  
				    })

    unless charge[:failure_code].blank?
      self.status = "failed"
      self.comment = charge[:failure_message]
    else
      self.status = 'complete'
      self.charge_id = charge[:id]
      self.amount = amount
      self.recorded_amount = charge[:amount]
      self.fingerprint = charge[:card][:fingerprint]
      self.coupon_id = coupon_id
    end

    rescue stripe::stripeerror => e
      logger.error "stripe error: " + e.message
      errors.add :base, "#{e.message}."
      self.status = "failed"
      self.comment = e.message
      self.amount = 0
    end
end

def charge_paypal
  charge_amount = self.amount * 100

	  request = Paypal::Express::Request.new(
		  username: Rails.config.paypal[:user],
		  password: Rails.config.paypal[:password],
		  signature: Rails.config.paypal[:signature]
		)
	  payment_request = Paypal::Payment::Request.new(
		 currency_code: :USD,
		 amount: charge_amount,
		 description: self.comment
	       )
	 response = request.setup(
		 payment_request,
		 update_payment_url(self),
		 delete_payment_url(self)
		)
	response.redirect_uri
end

