module SignupHelper
	
	def paypal_enabled?
		SiteConfig.last.paypal_enabled
	end

	def stripe_enabled?
		SiteConfig.last.stripe_enabled
	end

	def us_price
		SiteConfig.last.default_us_price
	end

	def ca_price
		SiteConfig.last.default_ca_price
	end

end
