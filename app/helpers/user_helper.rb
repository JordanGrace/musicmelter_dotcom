module UserHelper

	def age_values
		ages = [['Select your age','']]
		(13..60).step(1) do |n|
			ages.push([n])
		end
		ages
	end

end
