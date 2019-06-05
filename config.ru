#Configuration for the server
require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader' if development?
require_relative './controller/posts_controller'

use Rack::MethodOverride
run PostController
