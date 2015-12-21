class Post < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
  has_many :messages

  validates :title, :content, presence: true
end
