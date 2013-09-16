 include Rack::Test::Methods 

 describe "Going to the default index page for the app" do 

	 	before(:all) do
	    @repo = Repository.for(:board)
	    @repo.create (Board.new({name: "Board"}) )
	  end

 		it "should bring back the index page with no errors" do
 			get "/"
 			last_response.status.should == 200
	 	end

	 	after(:all) do
	 		@repo.delete_all
	 	end
 end