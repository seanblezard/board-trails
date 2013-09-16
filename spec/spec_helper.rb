# encoding: UTF-8
ENV['RACK_ENV'] ||= 'test'

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

def xhr(verb, path, params = {})
  send(verb,path, params, "HTTP_X_REQUESTED_WITH" => "XMLHttpRequest")
end 
