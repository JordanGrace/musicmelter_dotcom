class SiteConfig
  include Mongoid::Document
  field :accept_promos,         type: Boolean
  field :default_us_price,      type: BigDecimal
  field :default_ca_price,      type: BigDecimal
  field :stripe_enabled,        type: Boolean
  field :paypal_enabled,        type: Boolean

  validates_presence_of :accept_promos, :default_us_price, :default_ca_price

  private


end
