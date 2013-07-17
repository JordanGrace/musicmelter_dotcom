module UserHelper

	def age_values
		ages = ['Select your age']
		(18..60).step(1) do |n|
			ages.push([n,n])
		end
		ages
	end

end
