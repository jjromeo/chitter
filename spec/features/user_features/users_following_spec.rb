require 'spec_helper'
require_relative '../helpers/session'
require_relative '../helpers/tweet'

feature 'following a user' do
	include SessionHelpers
    include TweetHelpers

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

		it 'knows when it follows another user' do 
			expect(@james.followed_people.count).to eq 0
			@james.follow(@jerome)
			expect(@james.followed_people.count).to eq 1
		end

		it 'can follow a user on their profile' do 
			expect(@james.followed_people.count).to eq 0
			sign_in
			add_tweet('I (Jerome) love to tweet')
			sign_out
			sign_in('James')
			click_link('Jerome')
			click_button('follow')
			expect(@james.followed_people.count).to eq 1
		end
		
		# it 'and shows on their profile' do 
		# 	sign_in
		# 	click_link
		# end


	end

end