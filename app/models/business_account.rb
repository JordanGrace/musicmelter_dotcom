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

  validates_presence_of :name_first, :name_last, :business, :email
  validates_presence_of :phone, :address, :city, :state, :zip, :type

  embeds_many :payments

end
