module Controller

	class MoveCardOnBoard < Struct.new(:board_repository, :card_repository, :card_id, :new_lane_id)
		def perform(reporter)
  		card  = card_repository.find_by_id( card_id )	
   		board = board_repository.find_by_id( card.location.board_id ) 
   		new_lane = board.lanes.find_by_id(new_lane_id)

  		board.move_card_to(card, new_lane)			
			card = card_repository.update(card)  		

			if card.valid?
				reporter.card_moved_successfully(card)
			else
				reporter.problems_trying_to_move_card(card)
			end
		end
	end

end