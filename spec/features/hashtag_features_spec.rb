require 'spec_helper'
require_relative 'helpers/session'
require_relative 'helpers/tweet'
	
feature 'clickable hashtags' do 
	before do	
			@user =  User.create(username:"Jerome",
            email:"Jerome@test.com",
            password:"test",
            password_confirmation: "test")
			@newtweet = @user.tweets.create(content: 'I am such a #hashtagger', date: Time.now)
		end

	it "is a clickable link to other tweets with the same hashtag" do 
		parse_hashtags(@newtweet)
		render_hashtags(@newtweet)
		visit '/'
		expect(page).to have_link '#hashtagger'
	end
	
	it "clicking a link shows you all tweets which include that hashtag" do


		parse_hashtags(@newtweet)
		render_hashtags(@newtweet)
		visit '/'
		click_link '#hashtagger'
		expect(page).to have_content   'I am such a #hashtagger'	
	end
end
