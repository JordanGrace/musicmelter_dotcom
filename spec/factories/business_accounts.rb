# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :business_account do
        name_first  { Faker::Name.name }
        name_last   { Faker::Name.name }
        business    { Faker::Company.name }
        email       { Faker::Internet.email }
        address     { Faker::Address.street_address}
        city        { Faker::Address.city }
        state       { Faker::Address.state_abbr }
        zip         { Faker::Address.zip }
        type        { ['Tutor', 'Store', 'Instructor', 'Venue', 'Third Party'].sample }
        country     { Faker::Address.country }
  end

end
