class StripePayment < ActionMailer::Base
  default from: "noreply@musicmelter.com"


  def business_account_registration_receipt(business_account)
    @business_account = business_account
    @payment = @business_account.payments.last
    @confirmation = @payment.charge_id

    mail(:to => business_account.email, :subject => "Your receipt for $#{@payment.amount} to MusicMelter.com")
  end

end
