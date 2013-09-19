require 'spec_helper'

describe "Add a new card to an existing board" do
  
  before(:all) do
    @board_repo = Repository.for(:board)
    @card_repo = Repository.for(:card)

    @board        = Board.new({name:"Board"})
    @board.lanes << Board::Lane.new({name:"Backlog"})
    @board        = @board_repo.create( @board )
  end

  it "should call back successfully with a card added to the board" do
		controller = Controller::AddCardToBoard.new(@board_repo, @card_repo, @board.id, "Build this product")   
		reporter = AddCardToBoardSpecReporter.new
		 
    controller.perform(reporter)   
		reporter.card.valid?.should eq true
  end     

  it "card should be piled next to the board as it hasn't been pinned to any lane yet" do
    controller = Controller::AddCardToBoard.new(@board_repo, @card_repo, @board.id, "Build this product")   
    reporter = AddCardToBoardSpecReporter.new
     
    controller.perform(reporter)   
    reporter.card.piled_next_to_board?.should eq true
  end     

  it "card should be put into the backlog lane" do
    controller = Controller::AddCardToBoard.new(@board_repo, @card_repo, @board.id, "Build this product", @board.lanes[0].id)   
    reporter = AddCardToBoardSpecReporter.new
     
    controller.perform(reporter)   
    reporter.card.location.lane_id.should eq @board.lanes[0].id
  end     


  after(:all) do
    @card_repo.delete_all
    @board_repo.delete_all
  end
end


class AddCardToBoardSpecReporter < Struct.new(:card)    
  def card_added_successfully(card)
    self.card = card
  end
end

