class Board 
	include DomainModel

	attr_accessor :name

	def valid?
		self.violations.size == 0		
	end

	def validate
		clear_violations
	  if self.name.nil? || self.name.length == 0
	  	self.violations << DomainViolation.new({message: "You have to supply a name for this new board"})
	  end
	end

end