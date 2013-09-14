#
# A model representation of the state of a card on a given day

class CardData 
	include DomainModel

	attr_accessor :card  #Card::Snapshot
	attr_accessor :board #Board::Snapshot
	attr_accessor :lane  #String
	attr_accessor :date  #Date
end