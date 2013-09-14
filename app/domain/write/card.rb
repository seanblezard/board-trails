#
# A model representation of a physical index card or sticky on a whiteboard
#

class Card 
	include DomainModel

	attr_accessor :title #String
	attr_accessor :board #Board::Snapshot

	#
	# Snapshot for exporting a reference
	#
	def snapshot
		Snapshot.new(@id, @title)
	end

	class Snapshot < Struct.new(:card_id, :card_title)
	end	

end