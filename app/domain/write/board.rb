require 'state_machine' 

#
# A model representation of a physical whiteboard (aggregate root)
# 
# The board is made up of lanes (which on a physical whiteboard could look like anything) that 
# represent states for the work in progress. 
#
#

class Board 
	include DomainModel

	attr_accessor :name 	#String
	attr_accessor :lanes  #Array of Board::Lane objects

	def initialize(attributes={})
		super(attributes)
		@lanes = [] 
	end	

	def validate
		super

		# Boards must have a name
		RequiresName.new(self)

	  # Lanes in a board must have a name
	  LanesMustBeNamed.new(self)
	end

	def retire_lane(name)
		@lanes.each do |lane|
			lane.retire if lane.name == name
		end
		nil
	end

	#
	# A model representing a particular lane or section of a physical whiteboard. 
	# Identified by being uniquely named
 	#

	class Lane < Struct.new(:name, :state)		
		def initialize (name=nil, state='active')
			super(name, state)
		end

		state_machine :state, :initial=>:active do
	    event :retire do
	      transition [:active]=>:retired
	    end
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
		  	board.violations << DomainModel::DomainViolation.new(message)
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
		  	board.violations << DomainModel::DomainViolation.new(message)
		  end
		end
	end

	#
	# Snapshot for exporting a reference
	#
	def snapshot
		Snapshot.new(@id, @name)
	end

	class Snapshot < Struct.new(:board_id, :board_name)
	end	

end