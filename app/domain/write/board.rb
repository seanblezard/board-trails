#
# A model representation of a physical whiteboard (aggregate root)
#

class Board 
	include DomainModel

	attr_accessor :name, :lanes

	def initialize(attributes={})
		super(attributes)
		@lanes = [] #Collection of Board::Lane objects
	end	

	def validate
		super

		# Boards must have a name
		RequiresName.new(self)

	  # Lanes in a board must have a name
	  LanesMustBeNamed.new(self)
	end


	#
	# A model representing a particular lane or section of a physical whiteboard. 
	# Identified by being uniquely named
 	#

	class Lane
		attr_accessor :name

		def initialize(name=nil)
			@name = name
		end
	end	


	#
	# Validation rules for this model
	#
	
	class RequiresName
		def initialize(board)
			message = "You have to supply a name for this new board"
   		name = board.name
		  if name.nil? || name.length == 0
		  	board.violations << DomainModel::DomainViolation.new({message: message})
		  end
		end
	end

	class LanesMustBeNamed
		def initialize(board)
	  	lanes_with_no_name_count = 0
	  	board.lanes.each do |lane|
	  		lane_name = lane.name
	  		lanes_with_no_name_count += 1 if lane_name.nil? || lane_name.size==0	  		
	  	end
		  if lanes_with_no_name_count>0
				message = "You have #{lanes_with_no_name_count} lanes without a title. Fix this."
		  	board.violations << DomainModel::DomainViolation.new({message: message})
		  end
		end
	end

end