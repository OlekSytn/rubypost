require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @member = Member.new(name: 'Anyone', email: 'member@blog.com', password: 'password', confirmed_at: Time.now)
    @post = Post.new(title: 'Anything', author: @member)
    @like = Like.new(author: @member, post: @post)
  end

  it 'is valid with valid attributes' do
    expect(@like).to be_valid
  end

  it 'is not valid without valid attributes' do
    like_without_member = Like.new(post: @post)
    expect(like_without_member).to_not be_valid
  end

  it 'is not valid without valid attributes' do
    like_without_post = Like.new(author: @member)
    expect(like_without_post).to_not be_valid
  end

  it 'Author_id must be the member.id' do
    expect(@like.author_id).to be(@member.id)
  end

  it 'Post_id must be the post.id' do
    expect(@like.post_id).to be(@post.id)
  end

  it 'Likes counter must have value 1' do
    @new_member = Member.create(name: 'Anyone else', email: 'member@blog.com', password: 'password',
                                confirmed_at: Time.now)
    @new_post = Post.create(title: 'Something else', author: @new_member)
    new_like = Like.create(author: @new_member, post: @new_post)
    new_like.update_likes_counter
    expect(@new_post.likes_counter).to be(1)
  end

  it 'Likes counter must have value 5' do
    @new_member_a = Member.create(name: 'Anyone else 1', email: 'member_a@blog.com', password: 'password',
                                  confirmed_at: Time.now)
    @new_member_b = Member.create(name: 'Anyone else 2', email: 'member_b@blog.com', password: 'password',
                                  confirmed_at: Time.now)
    @new_member_c = Member.create(name: 'Anyone else 3', email: 'member_c@blog.com', password: 'password',
                                  confirmed_at: Time.now)
    @new_member_d = Member.create(name: 'Anyone else 4', email: 'member_d@blog.com', password: 'password',
                                  confirmed_at: Time.now)
    @new_member_e = Member.create(name: 'Anyone else 5', email: 'member_e@blog.com', password: 'password',
                                  confirmed_at: Time.now)
    @new_post = Post.create(title: 'Something else', author: @new_member_a)
    Like.create(author: @new_member_a, post: @new_post)
    Like.create(author: @new_member_b, post: @new_post)
    Like.create(author: @new_member_c, post: @new_post)
    Like.create(author: @new_member_d, post: @new_post)
    new_like = Like.create(author: @new_member_e, post: @new_post)
    new_like.update_likes_counter
    expect(@new_post.likes_counter).to be(5)
  end
end
