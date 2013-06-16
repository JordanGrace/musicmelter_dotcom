class PaymentController < ApplicationController
    before_filter :set_account, :only => [:new, :create]
    
    def set_account
        @business_account = BusinessAccount.find(params[:business_account_id])
    end

    def index
        redirect_to new_business_account_payment_path
    end

    def new
        @payment = @business_account.payments.new
    end

    def create
         # Amount in cents
          @amount = 5000

          customer = Stripe::Customer.create(
            :email => @business_account.email,
            :card  => params[:stripeToken]
          )

          charge = Stripe::Charge.create(
            :customer    => customer.id,
            :amount      => @amount,
            :description => 'Test Charge',
            :currency    => 'usd'
          )

        rescue Stripe::CardError => e
          flash[:error] = e.message
          redirect_to charges_path

    end

    def update

    end

end
