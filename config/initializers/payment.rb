require 'paypal/express'

Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
  :secret_key      => ENV['STRIPE_SECRET']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

Rails.configuration.paypal = {
	:client => ENV['PAYPAL_CLIENT'],
	:secret => ENV['PAYPAL_SECRET'],
	:user => ENV['PAYPAL_USER'],
	:pass => ENV['PAYPAL_PASS'],
	:signature => ENV['PAYPAL_SIGNATURE'],
	:sandbox => ENV['PAYPAL_SANDBOX']
}

Paypal.sandbox! if RAILS.configuration.paypal[:sandbox]
