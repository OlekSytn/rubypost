require 'rails_helper'

RSpec.describe Member, type: :model do
  before(:each) do
    @member = Member.new(name: 'Anyone', email: 'email@blog.com', password: 'password', confirmed_at: Time.now)
  end

  it 'is valid with valid attributes' do
    expect(@member).to be_valid
  end

  it 'is not valid without a name' do
    @member.name = nil
    expect(@member).to_not be_valid
  end

  it 'Name must not be blank' do
    @member.name = ' '
    expect(@member).to_not be_valid
  end

  it 'PostsCounter must be an integer greater than or equal to zero' do
    expect(@member.post_counter).to be_an(Numeric)
    expect(@member.post_counter).to be >= 0
  end

  it 'Recent posts must be empty array' do
    expect(@member.recent_posts.size).to be(0)
  end
end

describe 'Tests with new member' do
  before(:each) do
    @new_member = Member.create(name: 'Anyone else', email: 'other@blog.com', password: 'password',
                                confirmed_at: Time.now)
  end

  it 'Recent posts must not be empty array' do
    Post.create(title: 'Something 1', author: @new_member)
    expect(@new_member.recent_posts.size).to be(1)
  end

  it 'Recent posts must have title Something 1' do
    Post.create(title: 'Something 1', author: @new_member)
    expect(@new_member.recent_posts[0].title).to eql('Something 1')
  end

  it 'Recent posts must have size 2' do
    Post.create(title: 'Something 1', author: @new_member)
    Post.create(title: 'Something 2', author: @new_member)
    expect(@new_member.recent_posts.size).to be(2)
  end

  it 'Recent posts must have size 3' do
    Post.create(title: 'Something 1', author: @new_member)
    Post.create(title: 'Something 2', author: @new_member)
    Post.create(title: 'Something 3', author: @new_member)
    expect(@new_member.recent_posts.size).to be(3)
  end

  it 'Recent posts must must have size 3' do
    Post.create(title: 'Something 1', author: @new_member)
    Post.create(title: 'Something 2', author: @new_member)
    Post.create(title: 'Something 3', author: @new_member)
    Post.create(title: 'Something 4', author: @new_member)
    expect(@new_member.recent_posts.size).to be(3)
  end

  it 'Recent posts must must have the recent posts' do
    Post.create(title: 'Something 1', author: @new_member)
    Post.create(title: 'Something 2', author: @new_member)
    Post.create(title: 'Something 3', author: @new_member)
    Post.create(title: 'Something 4', author: @new_member)
    expect(@new_member.recent_posts[0].title).to eql('Something 4')
    expect(@new_member.recent_posts[1].title).to eql('Something 3')
    expect(@new_member.recent_posts[2].title).to eql('Something 2')
  end
end
