module Controller

	class AddLaneToBoard < Struct.new(:repository, :board_id, :lane)
		def perform(reporter)
   		board = repository.find_by_id( board_id ) 
   		board.lanes << Board::Lane.new(lane)
   		
   		board = repository.update(board)

			if board.valid?
				reporter.lane_added_successfully(board)
			else
				reporter.problems_trying_to_add_lane(board)
			end
		end
	end

end