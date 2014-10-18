require 'bcrypt'
class User

	class Link
		
		include DataMapper::Resource

			storage_names[:default] = 'people_links'

			belongs_to :follower, 'User', key: true

			belongs_to :followed, 'User', key: true
	end
	
	include DataMapper::Resource

	attr_reader :password
	attr_accessor :password_confirmation

	property :id, Serial
	property :username, String, unique: true, message: "This username is already taken", required: true
	property :email, String, unique: true, message: "This email is already taken"
	property :password_digest, Text

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(username, password)
		user = first(username: username)

		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else
			nil
		end
	end

	has n, :links_to_followed_people, 'User::Link', child_key: [:follower_id]
	has n, :links_to_followers, 'User::Link', child_key: [:followed_id]

	has n, :followed_people, self,
		through: :links_to_followers,
		via: :follower

	has n, :followers, self,
		through: :links_to_followers,
		via: :follower

	def follow(others)
		followed_people.concat(Array(others))
		save
		self
	end

	def unfollow(others)
		links_to_followed_people.all(:followed => Array(others)).destroy!
		reload
		self
	end

	validates_confirmation_of :password
	validates_uniqueness_of :email
	validates_uniqueness_of :username

	has n, :tweets



end