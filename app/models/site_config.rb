class SiteConfig
  include Mongoid::Document
  field :default_subscription, type: String
  field :default_price, type: String
  field :accept_promos, type: Boolean

  validates_presence_of :accept_promos, :default_price, :default_subscription

  before_save :process_money

  private

  def process_money
    #default_price = number_to_currency(default_price, :unit => "$") 
  end

end
