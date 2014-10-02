require 'spec_helper'
require_relative 'helpers/session'

feature "User adds a new tweet" do 
	include SessionHelpers
	scenario "when browsing the homepage" do 
		visit '/'
		sign_up
		add_tweet("Look at me adding a nice lil tweet")
		expect(page).to have_content("Look at me adding a nice lil tweet")
	end

	def add_tweet(content, date = Time.now)
		within('#add-tweet') do 
		fill_in 'content', with: content
		click_button 'Tweet'
		end
	end

	scenario "Non-signed in user tries to add a tweet" do
		visit '/'
		add_tweet("Look at me adding a nice lil tweet")
		expect(page).to have_content("You must log in in order to post a tweet!")
	end


end

