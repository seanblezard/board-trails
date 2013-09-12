require 'spec_helper'

describe Repository do

  before(:all) do
    Repository.register(:board, MemoryRepository::BoardRepository.new)
  end

  describe "Repository" do
    it "should return a memory Board Repository" do
      Repository.for(:board).class.should eq MemoryRepository::BoardRepository
    end
  end
     
end

