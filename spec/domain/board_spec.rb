require 'spec_helper'

describe Board do
  before(:each) do
  end

  describe "creating a new board" do
    it "should not be valid without a name" do
      board = Board.new()
      board.valid?.should eq false    
    end

    it "should be valid if we name it" do
      board = Board.new({ name:'New Board' })
      board.valid?.should eq true
    end

  end
     
  after(:each) do
  end
end

