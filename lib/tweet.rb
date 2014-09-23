class Tweet

	include DataMapper::Resource

	property :id, Serial
	property :content, Text
	property :date, DateTime

end