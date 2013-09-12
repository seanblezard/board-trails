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

    it "should create a 'name is required' type erorr message when we forget to supply a name" do
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
     
  after(:each) do
  end

end

