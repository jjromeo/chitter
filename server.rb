require 'data_mapper'
require 'sinatra'
require 'haml'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './lib/tweet'
require './lib/user'

DataMapper.finalize

DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'super secret'

get '/' do 
	@tweets = Tweet.all
	tweet = Tweet.first
	haml :index
end
	
post '/tweets' do 
	content = params["content"]
	Tweet.create(	content: content,
					date: Time.now)
	redirect to('/')
end

get '/users/new' do 
	haml :"users/new"
end

post '/users' do 
	user = User.create(	username: params["username"],
						email: params["email"],
						password: params["password"])
	session[:user_id] = user.id
	redirect to ('/')
end


helpers do 
	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]
	end
end
