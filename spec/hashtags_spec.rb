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
			@user.tweets.create(content: 'I am having so much fun! #awesome!')
			expect(Hashtag.count).to eq 1
		end
	end

end