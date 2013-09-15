module Controller

	class ShowMyBoards < Struct.new(:repository)
		def perform(reporter)
			boards = repository.all
			reporter.retrieved_list_of_boards(boards)
		end
	end

end