class Talent
  include Mongoid::Document
  field :name, type: String
  field :type, type: String
  field :priority, type: Integer

  validates_uniqueness_of :name

end
