require 'spec_helper'

describe Board do

  before(:each) do
  end

  describe "creating a new board" do
    it "should not be valid without a name" do
      board = Board.new()
      board.validate
      board.valid?.should eq false    
    end

    it "should create a 'name is required' type error message when we forget to supply a name" do
      board = Board.new()
      board.validate
      board.violations.size.should eq 1
    end

    it "should be valid if we name it" do
      board = Board.new({ name:'New Board' })
      board.validate
      board.valid?.should eq true
    end
  end

  describe "adding lanes to a board" do
    it "should add a new lane called 'Backlog'" do 
      board = Board.new({name: "Project Board"})
      board.lanes << Board::Lane.new("Backlog")

      board.lanes.size.should eq 1
    end

    it "should assign an id to the board on adding the lane successfully" do 
      board = Board.new({name: "Project Board"})
      board.lanes << Board::Lane.new("Backlog")

      board.lanes[0].id.should_not eq nil
    end

    it "should create a board violation when I add a lane with no name" do 
      board = Board.new({name: "Project Board"})
      board.lanes << Board::Lane.new()

      board.validate
      board.violations.size.should eq 1
    end

    it "should not add a blank lane if I try to add one without a name" do 
      board = Board.new({name: "Project Board"})
      board.lanes << Board::Lane.new()

      board.validate
      board.lanes.size.should eq 0
    end    

  end

  describe "retiring lanes from a board" do
    it "should change the state of the lane from active to retired" do
      board = Board.new({name: "Project Board"})
      board.lanes << Board::Lane.new("Silly List")
      board.retire_lane("Silly List")

      board.lanes[0].retired?.should eq true
    end
  end

  after(:each) do
  end

end

