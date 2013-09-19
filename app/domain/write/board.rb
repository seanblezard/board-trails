require 'state_machine' 
require 'forwardable'

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
	attr_accessor :lanes  #Array of Board::Lane objects contained inside special LaneCollection object

	def initialize(attributes={})
		super(attributes)
		@lanes = LaneCollection.new 
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
	# A special collection (array) for holding and managing lanes
	#
	#

	class LaneCollection
  	extend Forwardable
  
	  def_delegators :@lanes, :[], :size, :map, :delete, :each, :reverse, :reverse!
	
	  def initialize
	    @lanes=[]
	  end

	  def remove_blank_lanes
	  	@lanes.each {|lane| @lanes.delete(lane) if lane.name.nil? || lane.name.length==0}
	  end

	  def << lane
	  	lane.id ||= Time.now.to_i #It only needs to be unique to this board
	  	@lanes << lane
	  end
	end


	#
	# A model representing a particular lane or section of a physical whiteboard. 
	# Identified by being uniquely named
 	#

	class Lane < Struct.new(:name, :state, :id)		
		def initialize (name=nil, state='active', id=nil)
			super(name, state, id)
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
			message = "You can't have board lanes without a name."

	  	lanes_with_no_name_count = 0
	  	board.lanes.each do |lane|
	  		lane_name = lane.name
	  		lanes_with_no_name_count += 1 if lane_name.nil? || lane_name.size==0	  		
	  	end
		  if lanes_with_no_name_count>0				
				board.lanes.remove_blank_lanes
		  	board.violations << DomainModel::DomainViolation.new(message)
		  end
		end
	end

end