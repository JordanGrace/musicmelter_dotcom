class User
  include Mongoid::Document
  include Mongoid::History::Trackable
  include Mongoid::Paranoia
  include Mongoid::Timestamps::Short

  field :name, type: String
  field :age, type: Integer
  field :talent, type: Array
  field :country, type: String
  field :postal, type: Integer
  field :state, type: String
  field :province, type: String
  field :email, type: String

  validates_uniqueness_of :email
  validates_presence_of :name, :age, :talent, :country, :postal, :email

end
