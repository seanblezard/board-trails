require 'spec_helper'

describe "Create a new board to track" do
  
  before(:all) do
    @repo = Repository.for(:board)
  end

  it "should call back successfully with the new board has been created" do
		controller = Controller::CreateBoard.new(@repo, "New board name")   
		reporter = CreateBoardSpecReporter.new
		 
    controller.perform(reporter)   
    reporter.ok.should eq true
		reporter.board.valid?.should eq true
  end     

  it "should call back to highlight a problem creating the board" do
    controller = Controller::CreateBoard.new(@repo, "")   
    reporter = CreateBoardSpecReporter.new
     
    controller.perform(reporter)   
    reporter.ok.should eq false
    reporter.board.valid?.should eq false
    reporter.board.violations.size.should eq 1
  end     

  after(:all) do
    @repo.delete_all
  end
end


class CreateBoardSpecReporter < Struct.new(:board, :ok)    
  def problems_trying_to_create_board(board)
    self.board = board
    self.ok = false
  end
  def board_created_successfully(board)
    self.board = board
    self.ok = true
  end
end

