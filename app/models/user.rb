class User < ActiveRecord::Base
	has_many :posts
	has_many :messages
	has_many :owners
	has_many :blogs, through: :owners
	has_many :comments
	has_many :comments, as: :imageable

	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	validates :first_name, :last_name, presence: true
	validates :email_address, presence: true, format: { with: email_regex }
end
