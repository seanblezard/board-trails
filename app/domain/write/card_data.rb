#
# A model representation of the state of a card on a given day

class CardData 
	include DomainModel

	attr_accessor :card #CardSnapshot
end