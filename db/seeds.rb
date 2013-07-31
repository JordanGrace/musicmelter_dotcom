# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  	#to function it must have a site configuration out the gate 
	SiteConfig.create([{ accept_promos: true, default_us_price: 600, default_ca_price: 600, stripe_enabled: true, paypal_enabled: true}])

	Talent.create([
		{ name: 'Vocals', type: 'D', priority: 1},
		{ name: 'Guitar', type: 'D', priority: 2},
		{ name: 'Drums', type: 'D', priority: 3},
		{ name: 'Bass', type: 'D', priority: 4},
		{ name: 'Keys', type: 'D', priority: 5},
		{ name: 'Strings', type: 'D', priority: 6},
		{ name: 'Woodwind', type: 'D', priority: 7},
		{ name: 'Brass', type: 'D', priority: 8},
		{ name: 'Synth', type: 'D', priority: 9},
		{ name: 'Band', type: 'D', priority: 10},
		{ name: 'Rapper', type: 'D', priority: 11},
		{ name: 'DJ', type: 'D', priority: 12},
		{ name: 'Other', type: 'D', priority: 99}
		])