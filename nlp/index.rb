require 'sinatra'

get '/' do
  @title = 'Hello world!'
  haml :index
end