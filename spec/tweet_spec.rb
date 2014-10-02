require 'spec_helper'

describe Tweet do 

	context "Demonstration of how datamapper works" do 
		it "should be created and then retried from the db" do 
			user =  User.create(username:"Jerome",
                    email:"Jerome@test.com",
                    password:"test",
                    password_confirmation: "test")
			expect(user.tweets.count).to eq(0)
			user.tweets.create(	content: "This is a nice long tweet to show that a tweet is text format and therefore can be quite long.",
							date: Time.now)
			expect(user.tweets.count).to eq(1)
			tweet = user.tweets.first
			expect(tweet.content).to eq("This is a nice long tweet to show that a tweet is text format and therefore can be quite long.")
			expect(tweet.date).not_to eq nil
			user.tweets.destroy
			expect(user.tweets.count).to eq(0)
		end
	end
end