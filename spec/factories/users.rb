# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Sterling Archer"
    age "21"
    talent ['guitar','rapper','drums']
    country "MyString"
    postal "15131"
    state "PA"
    province "Alberta"
    email "test@example.com"
  end
end
