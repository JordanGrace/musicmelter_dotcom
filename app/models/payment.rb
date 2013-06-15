class Payment
  include Mongoid::Document
  
  field :status,        type: String

  embedded_in :BusinessAccount, inverse_of: :payments

end
