module Controller

	class AddCardToBoard < Struct.new(:board_repository, :card_repository, :board_id, :title, :lane_id)
		def perform(reporter)
   		board = board_repository.find_by_id( board_id ) 
  			
   		card = Card.new({title: title, location: Card::Location.new(board_id, lane_id)})   		   	
	 		card = card_repository.create(card)

			if board.valid?
				reporter.card_added_successfully(card)
			else
				reporter.problems_trying_to_add_card(card)
			end
		end
	end

end