require 'data_mapper'
require 'sinatra'
require 'haml'
require 'rack-flash'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './lib/tweet'
require './lib/user'

DataMapper.finalize

DataMapper.auto_upgrade!

use Rack::Flash

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
	@user = User.new
	haml :"users/new"
end

post '/users' do 
	@user = User.new(username: params[:username],
						email: params[:email],
						password: params[:password],
						password_confirmation: params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect to ('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		haml :"users/new"
	end
end


helpers do 
	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]
	end
end
