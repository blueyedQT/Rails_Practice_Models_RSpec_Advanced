require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'requires a title' do 
  	post = Post.new(title: '')
  	post.valid?
  	expect(post.errors[:title].any?).to eq(true)
  end

  it 'requires content' do 
  	post = Post.new(content: '')
  	post.valid?
  	expect(post.errors[:content].any?).to eq(true)
  end

  describe 'relationships' do
    before do
      @user = User.create(first_name: 'Kobe', last_name: 'Bryant', email_address: 'kobe@lakers.com')
      @blog = Blog.create(name: 'A blog', description: 'This is a blog')
      @post = Post.create(blog: @blog, user: @user, title: 'Post title', content: 'Post content')
    end

    it 'belongs to a user' do
      post = @user.posts.create(blog: @blog, title: 'Post title', content: 'Post content')
      expect(post.user).to eq(@user)
    end

    it 'belongs to a blog' do
      post = @blog.posts.create(user: @user, title: 'Post title', content: 'Post content')
      expect(post.blog).to eq(@blog)
    end
    
    it 'has many messages' do
      message1 = @post.messages.create(user: @user, author: 'Phil Jackson', message: 'Zenmaster')
      message2 = @post.messages.create(user: @user, author: 'Andrew Bynum', message: 'Zen grasshopper')
      expect(@post.messages).to include(message1)
      expect(@post.messages).to include(message2)
    end

    it 'has many comments' do 
      comment1 = @post.comments.create(comment: 'Comment 1')
      comment2 = @post.comments.create(comment: 'Comment 2')
      expect(@post.comments).to include(comment1)
      expect(@post.comments).to include(comment2)
    end
  end
end
