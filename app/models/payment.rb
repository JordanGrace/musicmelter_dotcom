class Payment
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::History::Trackable

  field :status,        type: String
  field :comment,       type: String
  field :confirmation,  type: String


  embedded_in :business_account, inverse_of: :payments

  validates_presence_of :status, :comment
  #validates_presence_of :stripe, if: :status == 'Complete'

  #Stripe is the provider, they have
  # confirmation ids - every payment must be 
  # stamped with a stripe ID to complete the payment
  def complete_payment(stripe)
    self.confirmation = stripe
    self.status = 'Complete'
    self.save
  end

end
