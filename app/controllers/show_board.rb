module Controller

	class ShowBoard < Struct.new(:repository, :id)
		def perform(reporter)
			board = repository.find_by_id(id)
			reporter.retrieved_board(board)
		end
	end

end