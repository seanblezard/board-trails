require 'spec_helper'

describe "Show me an existing board" do
  
  before(:all) do
    @repo = Repository.for(:board)
    @board = @repo.create( Board.new({name:"Board"}) )
  end

  it "should call back successfully with the board we are looking for" do
		controller = Controller::ShowBoard.new(@repo, @board.id)   
		reporter = ShowBoardSpecReporter.new
		 
    controller.perform(reporter)   
		reporter.board.name.should eq(@board.name)
  end     

  after(:all) do
    @repo.delete_all
  end
end


class ShowBoardSpecReporter < Struct.new(:board)    
  def retrieved_board(board)
    self.board = board
  end
end

