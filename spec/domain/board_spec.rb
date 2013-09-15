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

    it "should create a board violation when I add a lane with no name" do 
      board = Board.new({name: "Project Board"})
      board.lanes << Board::Lane.new()

      board.validate
      board.violations.size.should eq 1
    end

  end

     
  after(:each) do
  end

end

