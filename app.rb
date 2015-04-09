require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra-index'

configure do
  register Sinatra::Index
  use_static_index 'index.html'
end

get '/hello/' do
  'Hi!'
end
