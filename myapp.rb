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


  get '/new' do
    haml :new
  end

  post '/create' do
    @entry = DataEntry.create(:entry => params[:entry])
    redirect  "/"
  end



end