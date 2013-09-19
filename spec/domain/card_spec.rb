require 'spec_helper'

describe Card do

  before(:all) do

  end

  describe "writing a new card" do
    it "should validate successfully a card called 'Do it'" do
      card = Card.new({title:"Do it"})
      card.validate
      card.valid?.should eq true    
    end

  it "should flag a card with no title as invalid" do
      card = Card.new()
      card.validate
      card.valid?.should eq false
    end    
  end

  after(:all) do

  end
end