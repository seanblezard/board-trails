require 'spec_helper'

describe "Add a lane to an existing board" do
  
  before(:all) do
    @repo = Repository.for(:board)
    @board = @repo.create( Board.new({name:"Board"}) )
  end

  it "should call back successfully with a board respelendent with a new 'Backlog' lane" do
		controller = Controller::AddLaneToBoard.new(@repo, @board.id, "Backlog")   
		reporter = AddLaneToBoardSpecReporter.new
		 
    controller.perform(reporter)   
		reporter.board.lanes[0].name.should eq "Backlog"
  end     

  after(:all) do
    @repo.delete_all
  end
end


class AddLaneToBoardSpecReporter < Struct.new(:board)    
  def lane_added_successfully(board)
    self.board = board
  end
end

