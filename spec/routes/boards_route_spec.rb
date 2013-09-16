 include Rack::Test::Methods 

 describe "Fetching the user's boards" do 

	 	before(:all) do
	    @repo = Repository.for(:board)
	    @repo.create (Board.new({name: "Board"}) )
	  end

 		it "should bring back one board HTML fragment" do
 			xhr :get, "/boards"
 			last_response.status.should == 200
 			last_response.body.index('Board').should > 1
	 	end

	 	after(:all) do
	 		@repo.delete_all
	 	end
 end