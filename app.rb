require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader' if development?

# W = %w(png gif jpg jpeg)
# STATIC_FILE_EXT = Regexp.new("(#{W.join('|')})$", true) # `true` => ignore case (/i)

module Sinatra
  module Index

    def self.registered(app)
      app.set :static_indices, []

      app.before do
        if app.static? && (request.get? || request.head?)
          orig_path = request.path_info
          path      = unescape(orig_path)
          query     = !request.query_string.empty? ? request.query_string : nil
          host      = request.host

          # && !path.to_s.match(STATIC_FILE_EXT)
          if !path.end_with?('/') && !path.to_s.include?(".")
            path = path << '/'
            if ENV['RACK_ENV'] == "development"
              new_url = URI::HTTP.build(host: request.host, port: 9292, path: path, query: query)
            else
              new_url = URI::HTTP.build(host: request.host, path: path, query: query)
            end

            redirect new_url, 302
          end

          app.static_indices.each do |idx|
            request.path_info = path + idx
            static!
          end

          request.path_info = orig_path
        end 
      end
    end

    def use_static_indices(*args)
      static_indices.concat(args.flatten)
    end

    alias_method :use_static_index, :use_static_indices
  end

  register Index
end

configure do
  register Sinatra::Index
  use_static_index 'index.html'
end

get '/max/' do
  "Max"
end