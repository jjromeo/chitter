require 'spec_helper'

feature "User browses the list of tweets" do 

	before(:each) {
		Tweet.create(	content: "This is the content of my tweet",
						date: Time.now)
	}

	scenario "When opening the home page" do 
		visit '/'
		expect(page).to have_content("This is the content of my tweet")
	end
end