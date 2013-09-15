# encoding: UTF-8

require 'sinatra'
require 'rabl'
require 'chronic'
require 'slim'


class BoardTrails < Sinatra::Base
	
	# #######################
	# Configure Slim
	# #######################	

	Slim::Engine.set_default_options :pretty => true
	set :slim, :layout_engine => :slim
	set :root, File.dirname(__FILE__)
	set :views, Proc.new { File.join(root, "app/views") }

	# #######################
	# Helper methods to test which environment we are running against
	# #######################	

	def development?
		ENV['RACK_ENV']=="development"
	end

	def test?
		ENV['RACK_ENV']=="test"
	end

	def production?
		ENV['RACK_ENV']=="production"
	end

	# #######################
	# Load classes
	# #######################

 	require_relative 'app/init.rb' #Chain of init.rb's into sub-directories

 	# #######################
 	# Configure repositories
 	# #######################
	
	configure :test, :development do
		Repository.register(:board, MemoryRepository::BoardRepository.new)
	end

	# #######################
	# Repo helper methods
	# #######################
	
	def board_repository
		Repository.for(:board)
	end 

	# ######################
	# Request helper methods
	# ######################

	#If we are doing full round-trips use layout, otherwise just return the fragment
	def use_layout?
		!request.xhr? && request.env['X-PJAX'].nil? 
	end

	# #######################
	# Advertised routes
	# #######################

	#
  # Render the root index page
	#
	get '/' do
		slim :index, :layout=>true, :locals => {js: 'index.js'}
	end


	#
  # Show me the boards I can see/track
	#
	get '/boards' do
		Controller::ShowMyBoards.new(board_repository).perform(self)
	end

	# Callback from controller
	def retrieved_list_of_boards(boards)		
    slim :"boards", :layout => use_layout?, :locals => {boards: boards}
	end

	#
	# I want to start tracking this board - create it for me 
	#
	post '/boards' do
		Controller::CreateBoard.new(board_repository, params[:name]).perform(self)
	end

	#Callbacks from controller
	def board_created_successfully(board)
		slim :"boards/created_successfully", :layout=>use_layout?, :locals => {board: board}
	end

	def problems_trying_to_create_board(board)
		slim :"boards/problems_trying_to_create", :layout=>use_layout?, :locals => {board: board}
	end

	#
	# Show me the detail screen for a board
	#
	get '/boards/:id' do
		Controller::ShowBoard.new(board_repository, params[:id]).perform(self)
	end

	def retrieved_board(board)
		slim :board, :layout=>use_layout?, :locals=> {board:board, js:"board.js"}
	end



	# Take me to the edit screen for an existing board

	# Update the details of an existing board

	# Add a new lane to an existing board 

	# Re-sort the order of the lanes on an existing board

	# Rename an existing lane in an existing board

	# Remove a lane from an existing board

	#






end