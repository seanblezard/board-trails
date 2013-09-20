require 'spec_helper'

describe "Add a new card to an existing board" do
  
  before(:all) do
    @board_repo = Repository.for(:board)
    @card_repo = Repository.for(:card)

    @board        = Board.new({name:"Board"})
    @board.lanes << Board::Lane.new({name:"Backlog"})
    @board.lanes << Board::Lane.new({name:"Doing"})
    @board        = @board_repo.create( @board )

    @backlog = @board.lanes[0]
    @doing =   @board.lanes[1]

    @card = Card.new({title:"Do it", 
                      location: Card::Location.new(@board.id, @backlog.id)})
    @card_repo.create @card
  end

  it "card location should have changed to the 'Doing' lane" do
		controller = Controller::MoveCardOnBoard.new(@board_repo, @card_repo, @card.id, @doing.id)   
		reporter   = MoveCardOnBoardSpecReporter.new
		 
    controller.perform(reporter)   
		reporter.card.location.lane_id.should eq @board.lanes[1].id
  end     

  it "card location should stay the same if I try to move to an unknown lane" do
    controller = Controller::MoveCardOnBoard.new(@board_repo, @card_repo, @card.id, "RUBBISH LANE ID")   
    reporter   = MoveCardOnBoardSpecReporter.new
     
    controller.perform(reporter)   
    reporter.card.location.lane_id.should eq @board.lanes[0].id
    reporter.ok.should == false
  end     


  after(:all) do
    @card_repo.delete_all
    @board_repo.delete_all
  end
end


class MoveCardOnBoardSpecReporter < Struct.new(:card, :ok)      
  def card_moved_successfully(card)
    self.ok = true
    self.card = card
  end

  def problems_trying_to_move_card(card)
    self.ok = false
    self.card = card
  end
end

