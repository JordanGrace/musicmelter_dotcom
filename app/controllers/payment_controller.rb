class PaymentController < ApplicationController
	before_filter :fetch_payment, :only => [:show, :success, :cancel]

	attr_reader :payment

	def index
	  redirect_to :status => 500	
	end

	def create
	end

	def update
	end

	def show

		redirect_to :status => 500 if @payment.blank?
		template = ""
		if @payment.status == "complete"
			render text: "success"
		else
			render text: "error"
			return
		end	
	end

	def success
	  debugger
	  @payment.complete!(params['token'],params['PayerID'])
	  redirect_to "/thankyou"
	end

	def cancel
	  @payment.cancel!
	end


protected

	def fetch_payment(payment_id = params[:payment_id])
	account = BusinessAccount.where('payments._id' => Moped::BSON::ObjectId(payment_id)).last
	  @payment = account.payments.find(payment_id)	
	  
	  raise "No Payment Record" unless @payment.present?
	end
end
