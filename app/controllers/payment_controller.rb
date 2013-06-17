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
        @payment = @business_account.payments.new
    end

    def create
         # Amount in cents
          @amount = 60000
          if @business_account.customer_id.nil?
              customer = Stripe::Customer.create(
                :email => @business_account.email,
                :card  => params[:payment][:stripe_card_token]
              )
              @business_account.customer_id = customer.id
              @business_account.save
          end

          unless @business_account.payments.count > 0 
              payment = @business_account.payments.new({comment: "signup", status: 'active' })
              
              unless @business_account.coupon_redeem? || @business_account.coupon_code.nil?
                charge = Stripe::Charge.create(
                  :customer    => @business_account.customer_id,
                  :amount      => @amount,
                  :description => "signup",
                  :currency    => 'usd',
                  :coupon      => @business_account.coupon_code
                )
                @business_account.coupon_redeem = true
              else
                charge = Stripe::Charge.create(
                  :customer    => @business_account.customer_id,
                  :amount      => @amount,
                  :description => "signup",
                  :currency    => 'usd',
                  :coupon      => @business_account.coupon_code
                )
              end
              payment.complete_payment charge
              
              unless payment.save!
                flash[:error] = payment.errors.to_s
                redirect_to new_business_account_payment_path
              end

              logger.warn "Leaving create"

          end
        
        rescue Stripe::CardError => e
          flash[:error] = e.message
          redirect_to new_business_account_payment_path

    end

    def update

    end


end
