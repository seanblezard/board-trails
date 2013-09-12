require 'spec_helper'

describe BoardCreator do

  describe "Board Creator" do
    it "should call back successfully" do
			creator = BoardCreator.new("Board name", Repository.for(:board))      
			reporter = BoardCreatorSpecReporter.new
			creator.perform(reporter)

			reporter.valid.should eq true
    end
  end

  
  class BoardCreatorSpecReporter
  	attr_accessor :valid, :violations

  	def board_created(board)
  		@valid=true
  	end

  	def board_creation_problem(violations)
  		@valid=false
  		@violations=violations
  	end
  end
     
end

