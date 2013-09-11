class Board 
	include DomainModel

	attr_accessor :name

	def valid?
		!self.name.nil? && self.name.length > 0
	end

end