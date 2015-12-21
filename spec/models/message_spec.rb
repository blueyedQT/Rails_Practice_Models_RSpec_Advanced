require 'rails_helper'

RSpec.describe Message, type: :model do
	it 'requires an author' do 
		message = Message.new(author: '')
		message.valid?
		expect(message.errors[:author].any?).to eq(true)
	end

	it 'requires a message' do 
		message = Message.new(message: '')
		message.valid?
		expect(message.errors[:message].any?).to eq(true)
	end

	describe 'relationships' do 
		before do 
			@user = User.create(first_name: 'Kobe', last_name: 'Bryant', email_address: 'kobe@lakers.com')
			@blog = Blog.create(name: 'A blog', description: 'This is a blog')
			@post = Post.create(blog: @blog, user: @user, title: 'Post title', content: 'Post content')
		end

		it 'belongs to a post' do 
			message = @post.messages.create(user: @user, author: 'Jackson', message: 'Goinks')
			expect(message.post).to eq(@post)
		end

		it 'belongs to a user' do 
			message = @user.messages.create(post: @post, author: 'Jackson', message: 'Goinks')
			expect(message.user).to eq(@user)
		end
	end
end
