module TweetHelpers

	def add_tweet(content, date = Time.now)
		within('#add-tweet') do 
		fill_in 'content', with: content
		click_button 'Tweet'
		end
	end

end