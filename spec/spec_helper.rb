# encoding: UTF-8
ENV['RACK_ENV'] ||= 'test'

# NOTE If setting RACK_ENV to integrated then remember to create a
# couch DB database instance called trails_test to use

require 'bundler'
Bundler.require

require 'rack/test'

require File.join(File.dirname(__FILE__), '..', 'boardtrails.rb')

# setup test environment
set :run, false
set :raise_errors, true
set :logging, true

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  BoardTrails
end