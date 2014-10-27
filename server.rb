require 'data_mapper'
require 'dm-constraints'
require 'sinatra'
require 'haml'
require 'rack-flash'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './lib/tweet'
require './lib/user'
require './lib/hashtag'

DataMapper.finalize

DataMapper.auto_upgrade!

use Rack::Flash

enable :sessions
set :session_secret, 'super secret'

get '/' do 
@user = current_user
	@tweets = Tweet.all
	haml :index
end

get '/hashtags/:hashtag' do 
	@hashtag = params[:hashtag]
	@tagged_tweets = Tweet.all.select {|tweet| tweet.content.include?("#{@hashtag}")
	}
	haml :"/hashtags/search"
end


post '/tweets' do 
	content = params["content"]
	@user = current_user
	if @user
		@newtweet = @user.tweets.create(content: content,
						date: Time.now)
		parse_hashtags(@newtweet)
		render_hashtags(@newtweet)
		redirect to('/')
	else
		flash[:notice] = "You must log in in order to post a tweet!"
		redirect to('/')
	end
end

get '/profile/:user' do 
	profile_username = params[:user]
	@other_user = User.first(profile_username)
	@user = current_user
	if @user == @other_user
		redirect to '/my_profile'
	else
		haml :"/users/other_profile"
	end
end

post "/users/follow_other" do 
	other = User.first(params[:other])
	user = current_user
	user.follow(other)
end

get '/my_profile' do 
	@user = current_user
	haml :"/users/user_profile"
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

get '/sessions/new' do 
	haml :"sessions/new"
end

post '/sessions' do 
	username, password = params[:username], params[:password]
	user = User.authenticate(username, password)
	if user
		session[:user_id] = user.id
		redirect to('/')
	else
		flash[:errors] = ["The username or password is incorrect"]
		haml :"sessions/new"
	end
end

delete '/sessions' do 
	session[:user_id] = nil
	flash[:notice] = "Goodbye!"
	redirect to('/')
end

def parse_hashtags(tweet)
	if tweet.content.include?("#")
		content_array = tweet.content.split
		hashtags = content_array.select {|word| word.start_with?('#')}
		hashtags.map {|hashtag| tweet.hashtags.create(content: hashtag, href:"hashtags/#{hashtag.slice(1..-1)}", tweet_id: tweet.id )}
	end
end

def render_hashtags(tweet)
	@tweet = tweet
	@tweet.hashtags.each {|hashtag| @tweet.content = @tweet.content.gsub(/(#{hashtag.content})/, "<a href='/#{hashtag.href}'>#{hashtag.content}</a>")}
	@tweet.save!
end

helpers do 
	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]
	end
end
