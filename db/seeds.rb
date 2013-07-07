# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  	#to function it must have a site configuration out the gate 
	SiteConfig.create([{ accept_promos: true, default_us_price: 600, default_ca_price: 600, stripe_enabled: true, paypal_enabled: true}])

