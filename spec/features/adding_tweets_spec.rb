require 'spec_helper'
require_relative 'helpers/session'

feature "User adds a new tweet" do 
	include SessionHelpers

	scenario "when browsing the homepage" do 
		
		sign_up
		expect(Tweet.count).to eq(0)
		visit '/'
		add_tweet("Look at me adding a nice lil tweet")
		expect(Tweet.count).to eq(1)
		tweet = Tweet.first
		expect(tweet.content).to eq("Look at me adding a nice lil tweet")
	end

	def add_tweet(content, date = Time.now)
	within('#add-tweet') do 
		fill_in 'content', with: content
		click_button 'Tweet'
		end
	end

end

