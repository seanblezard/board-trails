class Board 
	include DomainModel

	attr_accessor :name

	def validate
		super
	  if self.name.nil? || self.name.length == 0
	  	self.violations << DomainViolation.new({message: "You have to supply a name for this new board"})
	  end
	end

end