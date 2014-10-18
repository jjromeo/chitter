require 'spec_helper'
require_relative '../helpers/session'
require_relative '../helpers/tweet'

feature "User personal features" do 
    include SessionHelpers
    include TweetHelpers

  context "a signed in User" do 
   	before(:each) do 
        User.create(username: "Jerome",
                    email: "Jerome@test.com",
                    password: "test",
                    password_confirmation: "test")
    end
  end

  	it "has their own profile page prompting them to tweet if they haven't" do 
		sign_up
		click_link("Profile")
		expect(page).to have_content("Your tweets will show here")
  	end

  	it "displays their tweets" do 
  		sign_up
  		add_tweet("This tweet should be on my profile!")
  		click_link("Profile")
  		expect(page).to have_content("This tweet should be on my profile!")
  	end

  	it "does not display other users' tweets" do 
  		sign_up_other
  		add_tweet("This tweet should not be on Jerome's profile")
  		sign_out
  		sign_up
  		click_link("Profile")
  		expect(page).to have_content("Your tweets will show here")
  		expect(page).not_to have_content("This tweet should not be on Jerome's profile")
  	end

  	it "can view another users profile" do 
  		sign_up_other
  		add_tweet("This is James' tweet")
  		sign_out
  		sign_up
  		click_link("James")
  		expect(page).to have_content("This is James' tweet")
  	end
end



feature 'following a user' do
	context 'a users follower count can be updated' do 
		before do 
			@jerome = User.create(	username:"Jerome",
			                    	email:"Jerome@test.com",
			                    	password:"test",
			                    	password_confirmation: "test")
			@james = User.create(	username:"James",
			                    	email:"James@test.com",
			                    	password:"test",
			                    	password_confirmation: "test")
			@links = User::Link.all
		end

		it 'can follow other users' do 
			expect(@james.followed_people.count).to eq 0
			@james.follow(@jerome)
			expect(@james.followed_people.count).to eq 1
		end


	end

end

# feature 'user has a page with their tweets and bio' do 

# 	context 'visiting profile page' do 
# 		before do 
# 			@jerome = User.create(	username:"Jerome",
# 			                    	email:"Jerome@test.com",
# 			                    	password:"test",
# 			                    	password_confirmation: "test")
# 			@james = User.create(	username:"James",
# 			                    	email:"James@test.com",
# 			                    	password:"test",
# 			                    	password_confirmation: "test")
# 			@links = User::Link.all
# 		end

# 	end

# 	it 'a user should be able to visit their own' do 


# end
