
 FactoryGirl.define do
     factory :stripe_payments do
          id "ch_22H27hXYjmERae"
          object "charge"
          created 1371513407
          livemode false
          paid true
          amount 60000
          currency "usd"
          refunded false
          fee 1770
          card { FactoryGirl.create :card }
          fee_details { FactoryGirl.create :fee_details }
          captured true
          failure_message nil
          failure_code nil
          amount_refunded 0
          customer "cus_22H2o2gnluKxcE"
          invoice "in_22H2aYhAoZdnNp"
          description nil
          dispute nil

     end
 end
    
FactoryGirl.define do
    factory :fee_details do
        amount 1770
        currency "usd"
        type "stripe_fee"
        description "Stripe processing fees"
        application nil
        amount_refunded 0
    end
end

FactoryGirl.define do
    factory :card do
        object "card"
        last4 4242
        type "Visa"
        exp_month 1
        exp_year 2014
        fingerprint "XZ12pjL0OW1bJJV1"
        country "US"
        name nil
        address_line1 nil
        address_line2 nil
        address_city nil
        address_state nil
        address_zip nil
        address_country nil
        cvc_check nil
        address_line1_check nil
        address_zip_check nil
    end
end