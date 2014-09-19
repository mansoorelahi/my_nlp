require 'sinatra/base'
require 'dm-core'
require 'dm-migrations'
require 'haml'
require "pp"
require "bundler/setup"
require "opennlp"
require "opennlp/english"
require 'lib/named_entity_recognition'
require 'lib/sentence_detection'
require 'lib/chunking'




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
    data = DataEntry.get(params[:id].to_i).entry
    #puts data
    #data = File.read('sample.txt').gsub!("\n", "")
    result= NamedEntityRecognition.new(data)
    locations= result.location
    persons= result.person
    money= result.money
    pos= result.pos
    sentence=SentenceDetection.new(data)
    sentences=sentence.sentence_count
    chunks = Chunking.new(data).chunker

    hash = Hash.new
    hash["locations"] = locations
    hash["persons"] = persons
    hash["money"] = money
    hash["pos"] = pos
    hash["sentences"] = sentences
    hash["chunks"] = chunks
    haml :show_data , :locals => { :data => hash ,:value=>data }
  end

  post '/create' do
    if params[:entry]
      @entry = DataEntry.create(:entry => params[:entry])
    else
      @entry = DataEntry.create(:entry => params[:Entry])
    end
    redirect  "/"
  end


  get '/delete' do
    data = DataEntry.get(params[:id].to_i)
    data.destroy
    redirect  "/"
  end

  get '/pos' do
    haml :pos
  end


end