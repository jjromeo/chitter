class Tweet

	include DataMapper::Resource

	property :id, Serial
	property :content, Text
	property :date, DateTime

	belongs_to :user
	has n, :hashtags, through: Resource



end

