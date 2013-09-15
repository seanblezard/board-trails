require 'spec_helper'

describe "Retiring a lane from an existing board" do
  
  before(:all) do
    @repo = Repository.for(:board)
    @board = @repo.create( Board.new({name:"Board"}) )
    @board.lanes << Board::Lane.new("Backlog")
    @repo.update @board
  end

  it "should call back successfully with a board with one retired lane and no active ones" do
		controller = Controller::RetireLaneFromBoard.new(@repo, @board.id, "Backlog")   
		reporter = RetireLaneFromBoardSpecReporter.new
		 
    controller.perform(reporter)   
		reporter.board.lanes[0].retired?.should eq true
  end     

  after(:all) do
    @repo.delete_all
  end
end


class RetireLaneFromBoardSpecReporter < Struct.new(:board)    
  def lane_retired_successfully(board)
    self.board = board
  end
end

