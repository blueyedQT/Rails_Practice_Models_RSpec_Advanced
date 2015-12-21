class Blog < ActiveRecord::Base
	has_many :owners
	has_many :posts
	has_many :users, through: :owners
	has_many :comments, as: :imageable

	validates :name, :description, presence: true
end
