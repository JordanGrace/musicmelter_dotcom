require 'spec_helper'

describe "BusinessAccounts" do
  describe "GET /business_accounts" do
    it "shows the business registration form" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit new_business_account_path
      page.should have_content("Business Registration")
      #CC # field
      #page.should have_content("#number")

      #Coupon Field
      #page.should have_content("#coupon_code")
    end

    context "When filling out the form", js: true do

        it "submits successfully with valid input", js: true do
            visit new_business_account_path
            
            within('#new_business_account') do
                fill_in('First Name', with: "Test")
                fill_in('Last Name', with: "Smith")
                fill_in('Business Name', with: "Acme Inc")
                fill_in('Email', with: Faker::Internet.email)
                select('Vocal Coach', from: 'business_account_type')
                page.first('.murica').click
                select('Pennsylvania', from: 'business_account_state')
                page.first('input[data-stripe=number]').set('4242424242424242')
                page.first('input[data-stripe=code]').select('111')
                page.first('select[data-stripe=exp-month]').select('December')
                page.first('select[data-stripe=exp-year]').select('2015')
                check('show_coupon')
                fill_in('Secret Code', with: 'UnitTester')
                page.first('#submit').click
                
                current_path.should == '/thankyou'
            end
        end

        #     it "halts without a credit card", :js => true do
        #     visit new_business_account_path 
        #         fill_in('First Name', with: "Test")
        #         fill_in('Last Name', with: "Smith")
        #         fill_in('Business Name', with: "Acme Inc")
        #         fill_in('Email', with: Faker::Internet.email)
        #         select('Vocal Coach', from: 'business_account_type')
        #         page.first('.murica').click
        #         select('Pennsylvania', from: 'business_account_state')
        #         check('show_coupon')
        #         fill_in('Secret Code', with: 'UnitTester')
        #         page.first('#submit').click
        #         page.should have_content("Card Looks Invalid")
        #         page.should have_content("Missing CV Code")
        #         page.should have_content("Card Expired")

        #     end


        # it "halts form progression with invalid_input" do
        #     visit new_business_account_path
        #     fill_in('First Name', with: "Test")
        #     fill_in('Last Name', with: "Smith")
        #     click_on("submit")
        #     page.should have_content("Business can't be blank")
        # end







    end



  end
end
