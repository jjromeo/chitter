require 'spec_helper'
require_relative 'helpers/session'
require_relative 'helpers/tweet'

feature "User adds a new tweet" do 
	include SessionHelpers
	include TweetHelpers

	scenario "when browsing the homepage" do 
		visit '/'
		sign_up
		add_tweet("Look at me adding a nice lil tweet")
		expect(page).to have_content("Look at me adding a nice lil tweet")
	end


	scenario "Non-signed in user tries to add a tweet" do
		visit '/'
		add_tweet("Look at me adding a nice lil tweet")
		expect(page).to have_content("You must log in in order to post a tweet!")
	end

	scenario "signed in user posts a tweet" do 
		visit '/'
		sign_up
		add_tweet("Look at me adding a nice lil tweet")
		expect(page).to have_content('by Jerome')
	end


end

