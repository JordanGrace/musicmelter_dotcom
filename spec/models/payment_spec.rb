require 'spec_helper'

describe Payment do
    Stripe.api_key = ENV['stripe_key']

    let(:payment) { FactoryGirl.build(:payment) }
    before(:each) do
        stub_request(:post, "https://api.stripe.com/v1/customers").
         with(:body => {"card"=>"tok_111111111", "description"=>"MyString MyString", "email"=>"test@test.com"},
              :headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer sk_test_WQ62JCppYxctpsEiH0GBvfN6', 'Content-Length'=>'72', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Stripe/v1 RubyBindings/1.8.3', 'X-Stripe-Client-User-Agent'=>'{"bindings_version":"1.8.3","lang":"ruby","lang_version":"1.9.3 p429 (2013-05-15)","platform":"x86_64-darwin12.4.0","publisher":"stripe","uname":"Darwin devops 12.4.0 Darwin Kernel Version 12.4.0: Wed May  1 17:57:12 PDT 2013; root:xnu-2050.24.15~1/RELEASE_X86_64 x86_64"}'}).
         to_return(:status => 200, :body => "", :headers => {})
     end

    context "To validate it must " do
        it "have a comment" do
            expect(payment.comment).not_to eq(nil)
            expect(payment.comment).to eq("Signup")
        end
        it "have a status" do
            expect(payment.status).not_to eq(nil)
            expect(payment.status).to eq("Pending")
        end
    end

   
end
