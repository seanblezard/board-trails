#
# A model representation of a physical whiteboard.
#

class Board 
	include DomainModel

	attr_accessor :name

	def validate
		super
		name = self.name
	  if name.nil? || name.length == 0
	  	@violations << DomainViolation.new({message: "You have to supply a name for this new board"})
	  end
	end

end