module Controller

	class CreateBoard < Struct.new(:repository, :name)
		def perform(reporter)
   		board = repository.create( Board.new({name: name}) ) 

			if board.valid?
				reporter.board_created_successfully(board)
			else
				reporter.problems_trying_to_create_board(board)
			end
		end
	end

end