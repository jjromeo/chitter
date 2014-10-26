require 'spec_helper'
require_relative 'helpers/session'
require_relative 'helpers/tweet'
	
feature 'clickable hashtags' do 
	before do	
			@user =  User.create(username:"Jerome",
            email:"Jerome@test.com",
            password:"test",
            password_confirmation: "test")
		end

	it "is a clickable link to other tweets with the same hashtag" do 
		newtweet = @user.tweets.create(content: 'I am such a #hashtagger', date: Time.now)
		parse_hashtags(newtweet)
		render_hashtags(newtweet)
		visit '/'
		expect(page).to have_link '#hashtagger'
	end

end
