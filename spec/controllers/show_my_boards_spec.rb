require 'spec_helper'

describe "Show my board controller" do
  
  before(:all) do
    @repo = Repository.for(:board)
    @repo.create( @repo.new({name:"Board 1"}) )

  end

  it "should call back successfully with the one board that exists" do
		controller = Controller::ShowMyBoards.new(@repo)   
		reporter = ShowMyBoardsSpecReporter.new
		 
    controller.perform(reporter)   
		reporter.boards.size.should eq 1
  end     


  after(:all) do
    @repo.delete_all
  end
end


class ShowMyBoardsSpecReporter < Struct.new(:boards)    
  def retrieved_list_of_boards(boards)
    self.boards = boards
  end
end

