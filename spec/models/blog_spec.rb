require 'rails_helper'

RSpec.describe Blog, type: :model do
  it 'requires a name' do 
  	blog = Blog.new(name: '')
  	blog.valid? 
  	expect(blog.errors[:name].any?).to eq(true)
  end

  it 'requires a description' do 
  	blog = Blog.ew(description: '')
  	blog.valid?
  	expect(blog.errors[:description].any?).to eq(true)
  end

  describe 'relationships' do 
  	before do 
  		@user1 = User.create(firstname: 'Kobe', last_name: 'Bryant', email_address: 'kobe@lakers.com')
			@user2 = User.create(first_name: 'Julius', last_name: 'Randle', email_Address: 'julius@lakers.com')
			@blog = Blog.create(name: 'A Blog', description: 'This is a blog')
		end

		it 'has many posts' do 
			post1 = @blog.posts.create(user: @user1, title: 'Coolio', content: 'Cool beans')
			post2 = @blog.posts.create(user: @user2, title: 'Foolio', content: 'Fool beans')
			expect(@blog.posts).to include(post1)
			expect(@blog.posts).to include(post2)
		end

		it 'has many owners' do 
			owner1 = @blog.owners.create(user: @user1)
			owner2 = @blog.owners.create(user: @user2)
			expect(@blog.owners).to include(owner1)
			expect(@blog.owners).to include(owner2)
		end

		it 'has many users through owners' do 
			@blog.owners.create(user: @user1)
			@blog.owners.create(user: @user2)
			expect(@blog.users).to include(@user1)
			expect(@blog.users).to include(@user2)
		end
	end
end
