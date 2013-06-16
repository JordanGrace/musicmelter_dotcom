class BusinessAccount
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :name_first, :type => String
  field :name_last, :type => String
  field :business, :type => String
  field :email, :type => String
  field :phone, :type => String
  field :address, :type => String
  field :city, :type => String
  field :state, :type => String
  field :zip, :type => String
  field :type, :type => String
  field :customer_id, :type => String

  validates_presence_of :name_first, :name_last, :business, :email
  validates_presence_of :phone, :address, :city, :state, :zip, :type

  #TODO: Validate Canadian Zip based on country of origin
  #validates_format_of :zip, with: '\b[ABCEGHJKLMNPRSTVXY][0-9][A-Z] [0-9][A-Z][0-9]\b' 

  embeds_many :payments

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
      self.payments.last.status == "Complete" && self.customer_id != nil  && self.payments.count != 0
    end

end
