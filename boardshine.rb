# encoding: UTF-8

require 'sinatra'
require 'rabl'
require 'chronic'

#
# (1) Configure Slim
#
Slim::Engine.set_default_options :pretty => true
set :slim, :layout_engine => :slim


class BoardShine < Sinatra::Base

  get '/' do
    slim :index, :layout=>true
  end

end