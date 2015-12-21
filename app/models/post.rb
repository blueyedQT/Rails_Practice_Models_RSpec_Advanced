class Post < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
  has_many :messages
  has_many :comments, as: :imageable

  validates :title, :content, presence: true
end
