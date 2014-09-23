require 'data_mapper'
require 'sinatra'
require 'haml'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './lib/tweet'

DataMapper.finalize

DataMapper.auto_upgrade!


get '/' do 
	@tweets = Tweet.all
	tweet = Tweet.first
	erb :index
end

post '/tweets' do 
	content = params["content"]
	Tweet.create(	content: content,
					date: Time.now)
	redirect to('/')
end