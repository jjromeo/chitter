require 'spec_helper'

feature "User browses the list of tweets" do 

	before(:each) {
		Tweet.create(content: "This is the content of my tweet")
	}

	scenario "When opening the home page" do 
		visit '/'
		epxect(page).to have_content("Chitter")
	end
end