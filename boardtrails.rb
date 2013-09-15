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




	# #######################
	# Advertised routes
	# #######################

	#
  # First off, I want to see the boards I am already measuring and tracking
	#
	get '/' do
		Controller::ShowMyBoards.new(board_repository).perform(self)
	end

	# Callback from controller
	def retrieved_list_of_boards(boards)
		@boards=boards
		slim :index, :layout=>true
	end


	#
	# I want to create a new board to start gathering data against a process
	#
	get '/boards/new' do
		@board = board_repository.new
		slim :"boards/new", :layout=>true
	end


	#
	# OK, I've entered all of the details for a new board, create it for me
	#





	# Take me to the edit screen for an existing board

	# Update the details of an existing board

	# Add a new lane to an existing board 

	# Re-sort the order of the lanes on an existing board

	# Rename an existing lane in an existing board

	# Remove a lane from an existing board

	#






end