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
  field :customer_id,	 type: String 
  field :provider,	 type: String
  field :raw_log,	 type: String 
  attr_accessor :stripe_token, :paypal_token
  attr_reader :redirect_uri, :popup_uri



  belongs_to :business_account
  embedded_in :business_account, inverse_of: :payments

  validates_presence_of :status, :comment

  scope :canceled,  where(status: "canceled") 
  scope :complete,  where(status: "complete") 
  scope :failed, where(status: "failed")


  # Stripe is the only provider so far, they have
  # confirmation ids - every payment must be 
  # stamped with a stripe ID to complete the payment
  def process 
    raise "No Payment Method" if self.stripe_token.blank? && self.paypal_token.blank?
    if self.stripe_token.present?
	self.provider = "stripe"	
	charge_stripe
    end  
    if self.paypal_token.present?
	self.provider = "paypal"
      	self.paypal_setup!("http://staging.musicmelter.com/payment/#{self.id}/success", "http://staging.musicmelter.com/payment/#{self.id}/cancel")
    end
end


 
# cancel!
#  Sets status to canceled. Returns payment object
#  = Example
#  payment.cancel!
def cancel!
	self.status = "canceled"
	self.save!
	self
end

# complete!
#
# = Example
#
def complete!(payer_id = nil, token = nil)
 if token.present? 
	 self.confirmation = token
 end
 response = paypal_client.checkout!(fingerprint, payer_id, paypal_payment_request)
 self.customer_id = payer_id
 self.charge_id = response.payment_info.first.transaction_id

 self.status = "complete"
 self.save!
 self

 rescue Paypal::Exception::APIError => e
  self.comment = e.message
  self.status = "error" 
  self.save!
end


def paypal_setup!(return_url, cancel_url)
	response = paypal_client.setup(
		paypal_payment_request,
		return_url,
		cancel_url,
		pay_on_paypal: true,
		no_shipping: true
	)
	self.fingerprint = response.token
	self.comment = response.redirect_uri
	self.save!
	
	rescue Paypal::Exception::APIError => e
	 self.comment = e.message

end

# paypal_payment_request
def paypal_payment_request 
  Paypal::Payment::Request.new(currency_code: :USD, amount: self.amount, description: self.comment)
	
end



def charge_stripe
    
    #stripe works in pennies
    charge_amount = self.amount * 100

    charge = Stripe::Charge.create({amount: charge_amount, 
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

    rescue Stripe::StripeError => e
      logger.error "stripe error: " + e.message
      errors.add :base, "#{e.message}."
      self.status = "failed"
      self.comment = e.message
      self.amount = 0
    end
end

private

# paypal_client 
# Returns the object used to communicate with Paypals API  
# = Example
# @paypal_client = payment.paypal_client 
def paypal_client
	Paypal::Express::Request.new Rails.configuration.paypal 
end


