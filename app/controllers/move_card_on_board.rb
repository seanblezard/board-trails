module Controller

	#
	# Move a card frome one lane to another - possibly even to a different board altogether (makes no difference)
	#

	class MoveCardOnBoard < Struct.new(:board_repository, :card_repository, :card_id, :new_lane_id)
		def perform(reporter)
  		card  	 = card_repository.find_by_id		( card_id )	
   		board 	 = board_repository.find_by_id	( card.location.board_id ) 
   		lane     = board.lanes.find_by_id(new_lane_id)
   		
  		card.move_on_board(board, lane)					
		  card_repository.update(card) 

			if card.valid? 
				reporter.card_moved_successfully(card)
			else
				reporter.problems_trying_to_move_card(card)
			end
		end
	end

end