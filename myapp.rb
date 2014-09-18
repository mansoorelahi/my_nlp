require 'sinatra/base'
require 'dm-core'
require 'dm-migrations'
require 'haml'

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

  get '/data' do
    haml :data_entry, :locals => { :data => DataEntry.all }
  end

  get '/new' do
    haml :new, :locals => { :data => DataEntry.all }
  end

  post '/create' do
    @entry = DataEntry.create(:entry => params[:entry])
    redirect  "/"
  end


  template :data_created do
    "%div\n" +
        "  Entry created\n" +
        "%a(href='/data') Enter more"
  end
end