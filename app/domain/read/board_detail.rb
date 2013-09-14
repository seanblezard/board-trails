#
# A read view/report of everything happening on a board
#

class BoardDetail < Struct.new(:id, :name, :lanes)
	class Lane < Struct.new(:name)
	end
end
