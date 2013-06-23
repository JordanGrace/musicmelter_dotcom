class Payment
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :status,         type: String,     default: 'active'
  field :comment,        type: String
  field :confirmation,   type: String
  field :charge_id,      type: String
  field :amount,         type: Integer
  field :fingerprint,    type: String
  field :coupon_id,      type: String
  attr_accessor :stripe_token

  belongs_to :business_account
  embedded_in :business_account, inverse_of: :payments

  validates_presence_of :status, :comment

  # Stripe is the only provider so far, they have
  # confirmation ids - every payment must be 
  # stamped with a stripe ID to complete the payment
  def process 
    raise "No Payment Method" if self.stripe_token.blank?
    
    #stripe works in pennies
    charge_amount = self.amount * 100

    charge = Stripe::Charge.create({amount: charge_amount, 
                                    customer: self.stripe_token,
                                    description: self.comment,
                                    currency: "usd"  
                                    })

    unless charge[:failure_code].blank?
      self.status = "Failed"
      self.comment = charge[:failure_message]
    else
      self.status = 'Complete'
      self.charge_id = charge[:id]
      self.amount = charge[:amount]
      self.fingerprint = charge[:card][:fingerprint]
      self.coupon_id = coupon_id
    end

    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "#{e.message}."
      self.status = "Failed"
      self.comment = e.message
      self.amount = 0
    end

end
