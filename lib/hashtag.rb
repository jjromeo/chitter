class Hashtag

	include DataMapper::Resource

	property :id, Serial
	property :content, String
	property :href, String

	belongs_to :tweet
	has n, :tweets, through: Resource

end

# tweet = Tweet.create
# hashtag = Hashtag.create
# tweet.hashtags << hashtag
# tweet.hashtags.save
