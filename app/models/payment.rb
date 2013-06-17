class Payment
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :status,        type: String,     default: 'active'
  field :comment,       type: String
  field :confirmation,  type: String
  field :charge_id,     type: String
  field :amount,        type: Integer
  field :fingerprint,    type: String
  attr_accessor :stripe_token

  belongs_to :business_account
  embedded_in :business_account, inverse_of: :payments

  validates_presence_of :status, :comment

  #Stripe is the provider, they have
  # confirmation ids - every payment must be 
  # stamped with a stripe ID to complete the payment
  def complete_payment(charge)
    unless charge == {}
      self.status = 'Complete'
      self.charge_id = charge[:id]
      self.amount = charge[:amount]
      self.fingerprint = charge[:card][:fingerprint]
      self.save
    end
  end

end
