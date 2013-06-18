class PaymentController < ApplicationController
    layout "layouts/stripe"
    before_filter :set_account, :only => [:new, :create, :applyCoupon]
    
    def set_account
        @business_account = BusinessAccount.find(params[:business_account_id])
    end

    def index
        redirect_to new_business_account_payment_path
    end

    def new
        @payment = @business_account.payments.new({amount: "600"})
    end

    def create
        payment = @business_account.payments.new(params[:payment])
        #be implicit with applying the token
        payment.stripe_token = params[:payment][:stripe_token]

        @business_account.process_payment(payment)

        customer = Stripe::Customer.retrieve(@business_account.customer_id)
        #now subscribe to the deal
        customer.update_subscription(plan: "earlyadopter")
        @business_account.subscription = customer.subscription.plan.id
        
        payment.status = "Complete"
        payment.comment = "EarlyAdopter Signup"
        payment.save
        @business_account.payments.push(payment)

        redirect_to "/thankyou"

        rescue => e
          flash[:error] = e.message
          render :text => e.message

    end


end


