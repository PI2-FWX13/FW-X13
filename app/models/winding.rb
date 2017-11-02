class Winding < ApplicationRecord

	def self.search(search)
	  where("projectName LIKE ?", "%#{search}%") 
	end

end
