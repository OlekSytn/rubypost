require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @member = Member.new(name: 'Anyone', email: 'member@blog.com', password: 'password', confirmed_at: Time.now)
    @post = Post.new(title: 'Anything', author: @member)
    @comment = Comment.new(text: 'Something', author: @member, post: @post)
  end

  it 'is valid with valid attributes' do
    expect(@comment).to be_valid
  end

  it 'is not valid without valid attributes' do
    comment_without_member = Comment.new(text: 'Something', post: @post)
    expect(comment_without_member).to_not be_valid
  end

  it 'is not valid without valid attributes' do
    comment_without_post = Comment.new(text: 'Something', author: @member)
    expect(comment_without_post).to_not be_valid
  end

  it 'Text must not be blank' do
    @comment.text = ' '
    expect(@comment).to_not be_valid
  end

  it 'Text must not exceed 250 characters' do
    @comment.text = 'b' * 251
    expect(@comment).to_not be_valid
  end

  it 'Author_id must be the member.id' do
    expect(@comment.author_id).to be(@member.id)
  end

  it 'Post_id must be the post.id' do
    expect(@comment.post_id).to be(@post.id)
  end

  it 'Post counter must have value 1' do
    @new_member = Member.create(name: 'Anyone else', email: 'member@blog.com', password: 'password',
                                confirmed_at: Time.now)
    @new_post = Post.create(title: 'Something else', author: @new_member)
    @new_comment = Comment.create(text: 'Something 1', author: @new_member, post: @new_post)
    @new_comment.update_comments_counter
    expect(@new_post.comments_counter).to be(1)
  end

  it 'Post counter must have value 6' do
    @new_member = Member.create(name: 'Anyone else', email: 'member@blog.com', password: 'password',
                                confirmed_at: Time.now)
    @new_post = Post.create(title: 'Something else', author: @new_member)
    Comment.create(text: 'Something 1', author: @new_member, post: @new_post)
    Comment.create(text: 'Something 2', author: @new_member, post: @new_post)
    Comment.create(text: 'Something 3', author: @new_member, post: @new_post)
    Comment.create(text: 'Something 4', author: @new_member, post: @new_post)
    Comment.create(text: 'Something 5', author: @new_member, post: @new_post)
    @new_comment = Comment.create(text: 'Something 6', author: @new_member, post: @new_post)
    @new_comment.update_comments_counter
    expect(@new_post.comments_counter).to be(6)
  end
end
