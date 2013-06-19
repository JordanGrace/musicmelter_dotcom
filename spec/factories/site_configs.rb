# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site_config do
    default_subscription "MyString"
    default_price "MyString"
    accept_promos false
  end
end
