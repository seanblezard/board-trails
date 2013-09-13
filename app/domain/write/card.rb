#
# A model representation of a physical index card or sticky on a whiteboard
#

class Card 
	include DomainModel

	attr_accessor :title
	attr_accessor :board #BoardSnapshot
	
end