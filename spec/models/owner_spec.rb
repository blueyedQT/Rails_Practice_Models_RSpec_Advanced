require 'rails_helper'

RSpec.describe Owner, type: :model do
  describe 'relationships' do 
  	before do 
  		@user = User.create(first_name: 'Kobe', last_name: 'Bryant', email_address: 'kobe@lakers.com')
  		@blog = Blog.create(name: 'A Blog', description: 'This is a blog')
  	end

  	it 'belongs to a user' do 
  		owner = @user.owners.create(blog: @blog)
  		expect(owner.user).to eq(@user)
  	end

  	it 'belongs to a blog' do 
  		owner = @blog.owners.create(user: @user)
  		expect(owner.blog).to eq(@blog)
  	end
  end
end
