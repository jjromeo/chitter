require 'spec_helper'

describe Tweet do 

	context "Demonstration of how datamapper works" do 
		it "should be created and then retried from the db" do 
			expect(Tweet.count).to eq(0)
			Tweet.create(content: "This is a nice long tweet to show that a tweet is text format and therefore can be quite long.")
			expect(Tweet.count).to eq(1)
			tweet = Tweet.first
			expect(tweet.content).to eq("This is a nice long tweet to show that a tweet is text format and therefore can be quite long.")
			tweet.destroy
			expect(Tweet.count).to eq(0)
		end
	end
end