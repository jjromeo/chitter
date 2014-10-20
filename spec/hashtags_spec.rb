require 'spec_helper'

describe Hashtag do 

	context 'They can be used to tag a tweet' do 
		before do	
			@user =  User.create(username:"Jerome",
            email:"Jerome@test.com",
            password:"test",
            password_confirmation: "test")
		end

		it 'is created when a tweet is made' do 
			expect(Hashtag.count).to eq 0
			# newtweet = @user.tweets.create(content: 'I am having so much fun!')
			newtweet = @user.tweets.create(content: 'I am having so much fun! #awesome')
			parse_hashtags(newtweet)
			expect(Hashtag.count).to eq 1
			expect(Hashtag.first.content).to eq "#awesome"
		end
	end

end