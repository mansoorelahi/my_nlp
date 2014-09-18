require 'sinatra/base'
require 'dm-core'
require 'dm-migrations'
require 'haml'
require "pp"
require "bundler/setup"
require "opennlp"
require "opennlp/english"
require 'lib/named_entity_recognition'



class DataEntry
  include DataMapper::Resource

  property :id, Serial
  property :entry, String
end

class MyApp < Sinatra::Base
  configure do
    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(:default, 'sqlite:///tmp/survey.db')
    DataMapper.auto_upgrade!
  end

  get '/' do
    haml :index , :locals => { :data => DataEntry.all }
  end


  get '/new' do
    haml :new
  end

  get '/extract_data' do
    data = DataEntry.last.entry
    puts data
    result= NamedEntityRecognition.new(data)
    locations= result.location
    puts locations.inspect
    haml :show_data , :locals => { :data => locations }
  end

  post '/create' do
    @entry = DataEntry.create(:entry => params[:entry])
    redirect  "/"
  end
end