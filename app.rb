require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra-index'

configure do
  register Sinatra::Index
  use_static_index 'index.html'

  set :public_folder, proc { File.join(root, "build") }
end

get '/hello/' do
  'Hi!'
end
