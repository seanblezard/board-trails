require 'spec_helper'

describe Card do

  before(:all) do

  end

  describe "writing a new card" do
    it "should validate successfully a card called 'Do it'" do
      card = Card.new({title:"Do it"})
      card.validate
      card.valid?.should eq true    
    end

  it "should flag a card with no title as invalid" do
      card = Card.new()
      card.validate
      card.valid?.should eq false
    end    
  end

  describe "moving a card to a different lane on the board" do
    it "should change the lane of the card from the backlog lane to the doing lane" do
      board = Board.new({name: "Project Board"})
      board.lanes << Board::Lane.new("Backlog")
      board.lanes << Board::Lane.new("Doing")
      backlog = board.lanes[0]
      doing   = board.lanes[1]

      card = Card.new({title: "Do it", location: Card::Location.new({board_id: board.id, lane_id: backlog.id}) })

      card.move_on_board(board, doing)

      card.location.lane_id.should eq doing.id
    end
  end
     


  after(:all) do

  end
end