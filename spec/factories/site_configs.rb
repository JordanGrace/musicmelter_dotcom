# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site_config do
    accept_promos true
    stripe_enabled true
    paypal_enabled true
  	default_us_price 600.00
    default_ca_price 600.00
  end
end
