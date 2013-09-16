 include Rack::Test::Methods 

 describe "Go to the board details page" do 

	 	before(:all) do
	    @repo = Repository.for(:board)
	    @board = @repo.create (Board.new({name: "Board"}) )
	  end

 		it "should go to the board page" do
 			xhr :get, "/boards/#{@board.id}"
 			last_response.status.should == 200
 			last_response.body.index('Board').should > 1
	 	end

	 	after(:all) do
	 		@repo.delete_all
	 	end
 end