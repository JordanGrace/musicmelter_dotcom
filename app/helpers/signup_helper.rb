module SignupHelper
	
	def paypal_enabled?
		SiteConfig.last.paypal_enabled
	end

	def stripe_enabled?
		SiteConfig.last.stripe_enabled
	end

end
