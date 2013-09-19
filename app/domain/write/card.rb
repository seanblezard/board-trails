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

	class RequiresTitle
		def initialize(card)
			message = "You have to supply a title for this card"
   		title = card.title
		  if title.nil? || title.length == 0
		  	card.violations << DomainModel::DomainViolation.new(message)
		  end
		end
	end

end