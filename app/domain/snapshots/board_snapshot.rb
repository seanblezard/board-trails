# Snapshots of another entity, used as an information-rich "foreign key"

class BoardSnapshot < Struct.new(:id, :name)
end	
