class User
  include Mongoid::Document
  include Mongoid::History::Trackable
  include Mongoid::Paranoia
  include Mongoid::Timestamps::Short

  field :name,      type: String
  field :age,       type: Integer
  field :country,   type: String
  field :postal,    type: Integer
  field :state,     type: String
  field :province,  type: String
  field :email,     type: String

  attr_accessor :hidden_talent
 
  has_and_belongs_to_many :talents, inverse_of: nil

  validates_uniqueness_of :email
  validates_presence_of :name, :age, :country, :postal, :email
  validates :age, :numericality => {:only_integer => true}


  after_create :complete_registration



  #send the registration email
  def complete_registration
    Userregistration.user_registration_receipt(self).deliver
  end
end
