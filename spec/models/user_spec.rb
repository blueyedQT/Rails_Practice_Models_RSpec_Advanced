require 'rails_helper'

RSpec.describe User, type: :model do
  it 'requires a first name' do
  	user = User.new(first_name: '')
  	user.valid?
  	expect(user.errors[:first_name].any?).to eq(true)
  end

  it 'requires a last name' do 
  	user = User.new(last_name: '')
  	user.valid? 
  	expect(user.errors[:last_name].any?).to eq(true)
  end

  it 'requires an email address' do 
  	user = User.new(email_address: '')
  	user.valid?
  	expect(user.errors[:email_address].any?).to eq(true)
  end

  it 'accepts properly formated email addresses' do
  	emails = ['kobe@lakers.com', 'kobe.bryant@lakers.com']
  	emails.each do |email| 
  		user = User.new(email_address: email)
  		user.valid?
  		expect(user.errors[:email_address].any?).to eq(false)
  	end
  end

	it 'rejects improperly formatted email address' do 
		emails = ['kobe@lakers', 'kobe.com']
		emails.each do |email|
			user = User.new(email_address: email)
			user.valid?
			expect(user.errors[:email_address].any?).to eq(true)
		end
	end

	describe 'relationships' do 
		before do 
			@user = User.create(first_name: 'Kobe', last_name: 'Bryant', email_address: 'kobe@lakers.com')
			@blog = Blog.create(name: 'A Blog', description: 'This is a blog')
			@post = Post.create(blog: @blog, user: @user, title: 'Post title', content: 'Post content')
		end

		it 'has many posts' do 
			post1 = @user.posts.create(blog: @blog, title: 'Post title', content: 'Post content')
			post2 = @user.posts.create(blog: @blog, title: 'Post 2 title', content: 'Post 2 content')
			expect(@user.posts).to include(post1)
			expect(@user.posts).to include(post2)
		end

		it 'has many messages' do 
			message1 = @user.messages.create(post: @post, author: 'Phil Jackson', message: 'Zenmaster')
			message2 = @user.messages.create(post: @post, author: 'Andrew Bynum', message: 'Zen grasshopper')
			expect(@user.messages).to include(message1)
			expect(@user.messages).to include(message2)
		end

		it 'has many owners' do 
			owner1 = @user.owners.create(blog: @blog)
			owner2 = @user.owners.create(blog: @blog)
			expect(@user.owners).to include(owner1)
			expect(@user.owners).to include(owner2)
		end

		it 'has many blogs through owners' do 
			blog1 = Blog.create(name: 'A Blog', description: 'A description')
			blog2 = Blog.create(name: 'Another blog', description: 'Another description')
			@user.owners.create(blog: blog1)
			@user.owners.create(blog: blog2)
			expect(@user.blogs).to include(blog1)
			expect(@user.blogs).to include(blog2)
		end

		it 'has many comments' do 
			comment1 = @user.comments.create(comment: 'Comment 1')
			comment2 = @user.comments.create(comment: 'Comment 2')
			expect(@user.comments).to include(comment1)
			expect(@user.comments).to include(comment2)
		end
	end
end
