# Snapshots of another entity, used as an information-rich "foreign key"

class CardSnapshot < Struct.new(:id, :title)
end	
