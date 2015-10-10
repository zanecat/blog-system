class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	has_many :posts, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed

	has_many :reverse_relationships, foreign_key: "followed_id",
	class_name: "Relationship",
	dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower

	validates :name, presence: true, length: { maximum: 20 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	
	has_secure_password 
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end
	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
		# This is preliminary. See "Following users" for the full implementation.
		Post.where("user_id = ?", id)
	end

	def following?(other_user)
		relationships.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		relationships.find_by(followed_id: other_user.id).destroy
	end

	def postOfFollowing(users)
		post_list=[]
		users.collect do |user|		
			post_list<<user.posts
		end
		post_list.flatten
	end

	def self.search(search)
	    if search
	      where('name LIKE ?', "%#{search}%")
	    else
	      all
	    end
	end

	private
	def create_remember_token
		self.remember_token = User.encrypt(User.new_remember_token)
	end
end
