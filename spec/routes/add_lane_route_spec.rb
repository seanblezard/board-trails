 include Rack::Test::Methods 

 describe "Go to the board details page" do 

	 	before(:all) do
	    @repo = Repository.for(:board)
	    @board = @repo.create (Board.new({name: "Board"}) )
	  end

 		it "should add the new lane and return a list of one lane HTML fragment" do
 			xhr :post, "/boards/#{@board.id}/lanes", {name: "Backlog"}
 			last_response.status.should == 200
 			last_response.body.index('Backlog').should > 1
	 	end

	 	after(:all) do
	 		@repo.delete_all
	 	end
 end