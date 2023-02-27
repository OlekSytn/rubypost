require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  describe 'Show page for Lilly' do
    before(:each) do
      @member = FactoryBot.create(:member)
      @lilly = Member.create(name: 'Lilly', photo: 'https://c.tenor.com/YIeHLcvImMsAAAAM/meditation-dog.gif',
                             bio: 'Teacher from Poland', email: 'lilly@blog.com', password: 'password',
                             confirmed_at: Time.now)
      @tom = Member.create(name: 'Tom', photo: 'https://c.tenor.com/uj4Cnt7RVE0AAAAM/fatdog-dog.gif',
                           bio: 'Teacher from Mexico.', email: 'tom@blog.com', password: 'password',
                           confirmed_at: Time.now)
      @jim = Member.create(name: 'Jim', photo: 'https://c.tenor.com/lFZ9_tWmmEAAAAAM/please-doggy.gif',
                           bio: 'Teacher from Japan.', email: 'jim@blog.com', password: 'password',
                           confirmed_at: Time.now)
      @bill = Member.create(name: 'Bill', photo: 'https://c.tenor.com/x0eeZxeU56AAAAAM/puppy-cute.gif',
                            bio: 'Teacher from Uganda.', email: 'bill@blog.com', password: 'password',
                            confirmed_at: Time.now)
      @hello = Post.create(author: @lilly, title: 'Hello', text: 'This is my first post')
      Comment.create(post: @hello, author: @tom, text: 'First comment')
      Comment.create(post: @hello, author: @lilly, text: 'Second comment')
      Comment.create(post: @hello, author: @jim, text: 'Third comment')
      Comment.create(post: @hello, author: @bill, text: 'Fourth comment')
      Comment.create(post: @hello, author: @tom, text: 'Fifth comment')
      Like.create(post: @hello, author: @bill)
      Like.create(post: @hello, author: @jim)
      Like.create(post: @hello, author: @tom)
    end

    it "Shows the post's title" do
      sign_in @member
      visit member_post_path(@lilly, @hello)
      expect(page).to have_content('Hello')
      expect(page).to_not have_content('Hey')
    end

    it 'Show who wrote the post' do
      sign_in @member
      visit member_post_path(@lilly, @hello)
      expect(page).to have_content('by Lilly')
      expect(page).to_not have_content('by Luna')
    end

    it 'Show how many likes it has' do
      sign_in @member
      visit member_post_path(@lilly, @hello)
      expect(page).to have_content('3')
      expect(page).to_not have_content('4')
    end

    it "Show some of the post's body" do
      sign_in @member
      visit member_post_path(@lilly, @hello)
      expect(page).to have_content('This is my first post')
      expect(page).to_not have_content('This is my second post')
    end

    it 'Show the username of each commentor' do
      sign_in @member
      visit member_post_path(@lilly, @hello)
      expect(page).to have_content('Tom')
      expect(page).to have_content('Lilly')
      expect(page).to have_content('Bill')
      expect(page).to have_content('Jim')
    end

    it 'Show the comment each commentor left' do
      sign_in @member
      visit member_post_path(@lilly, @hello)
      expect(page).to have_content('First comment')
      expect(page).to have_content('Second comment')
      expect(page).to have_content('Third comment')
      expect(page).to have_content('Fourth comment')
      expect(page).to have_content('Fifth comment')
    end
  end
end
