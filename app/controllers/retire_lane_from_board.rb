module Controller

	class RetireLaneFromBoard < Struct.new(:repository, :board_id, :lane)
		def perform(reporter)
   		board = repository.find_by_id( board_id ) 
   		board.retire_lane lane   		
   		board = repository.update(board)

			if board.valid?
				reporter.lane_retired_successfully(board)
			else
				reporter.problems_trying_to_retire_lane(board)
			end
		end
	end

end