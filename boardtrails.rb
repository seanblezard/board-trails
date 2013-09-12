# encoding: UTF-8

require 'sinatra'
require 'rabl'
require 'chronic'
require 'slim'


class BoardTrails < Sinatra::Base
	#
	# Configure Slim
	#
	Slim::Engine.set_default_options :pretty => true
	set :slim, :layout_engine => :slim
	set :root, File.dirname(__FILE__)
	set :views, Proc.new { File.join(root, "app/views") }

	#
	# Environment tests
	#
	def development?
		ENV['RACK_ENV']=="development"
	end

	def test?
		ENV['RACK_ENV']=="test"
	end

	def production?
		ENV['RACK_ENV']=="production"
	end

	#
	# Load classes
	#
 	require_relative 'app/init.rb'

 	#
 	# Configure repositories
 	#
	configure :test, :development do
		Repository.register(:board, MemoryRepository::BoardRepository.new)
	end

	#
	# Routes
	#

  # Take me to the list of boards I can choose from (default page just now)
	get '/' do
		@boards = Repository.for(:board).all
		slim :index, :layout=>true
	end

	# Take me to the screen to create a new board

	# Create the new board and show me the details for it

	# Take me to the edit screen for an existing board

	# Update the details of an existing board

	# Add a new lane to an existing board 

	# Re-sort the order of the lanes on an existing board

	# Rename an existing lane in an existing board

	# Remove a lane from an existing board

	# 
end