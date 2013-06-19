# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :coupon_code do
    code "ArcherSucks"
    agent "Cyril Figgis"
    quantity 5
    redeemed 1
    amount 1
  end
end
