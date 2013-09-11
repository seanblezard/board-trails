# encoding: UTF-8

require 'sinatra'
require 'rabl'
require 'chronic'

#
# Configure Slim
#
Slim::Engine.set_default_options :pretty => true
set :slim, :layout_engine => :slim


class BoardTrails < Sinatra::Base

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
 	require_relative 'lib/init.rb'
 	require_relative 'domain/init.rb'

	#
	# Routes
	#

    # Take me to the list of boards I can choose from (default page just now)
	get '/' do
		slim :index, :layout=>true
	end

end