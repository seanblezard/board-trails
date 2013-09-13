#
# A read view/report of everything happening on a board
#

class BoardDetail
	attr_accessor :name, :lanes

	def initialize()
		@name=nil
		@lanes=[]
	end

	class Lane
		attr_accessor :name
	end
end
