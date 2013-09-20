#
# A model representation of a physical index card or sticky on a whiteboard
#

class Card 
	include DomainModel

	attr_accessor :title, :code, :location
	
	class Location < Struct.new(:board_id, :lane_id)
	end

  def validate
		super
		# Cards must have a title
		RequiresTitle.new(self)
	end

	def piled_next_to_board?
		self.location.lane_id == nil
	end

	def move_on_board(board, lane)	
		MustBeAValidLane.new(self, board, lane)
		self.location = Location.new(board.id, lane.id) if valid?
	end

	class RequiresTitle
		def initialize(card)
			message = "You have to supply a title for this card"
   		title = card.title
		  if title.nil? || title.length == 0
		  	card.violations << DomainModel::DomainViolation.new(message)
		  end
		end
	end

	class MustBeAValidLane
		def initialize(card, board, lane)
			message = "You can't move this card to a part of this board that doesn't exist. Sorry."   		
		  if lane.nil? || board.lanes.find_by_id(lane.id).nil?
		  	card.violations << DomainModel::DomainViolation.new(message)
		  end
		end
	end

end