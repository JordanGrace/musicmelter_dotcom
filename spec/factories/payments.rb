# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    status "Pending"
    comment "Signup"
    stripe "XJs13Zy"
  end
end
