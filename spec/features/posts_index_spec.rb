require 'rails_helper'

RSpec.describe 'Member post index page', type: :feature do
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
      Post.create(author: @lilly, title: 'Hey', text: 'This is my second post')
      Comment.create(post: @hello, author: @tom, text: 'First comment')
      Comment.create(post: @hello, author: @lilly, text: 'Second comment')
      Comment.create(post: @hello, author: @jim, text: 'Third comment')
      Comment.create(post: @hello, author: @bill, text: 'Fourth comment')
      Comment.create(post: @hello, author: @tom, text: 'Fifth comment')
      Like.create(post: @hello, author: @bill)
      Like.create(post: @hello, author: @jim)
      Like.create(post: @hello, author: @tom)
    end

    it "Shows the member's profile picture" do
      sign_in @member
      visit member_posts_path(@lilly)
      expect(page).to have_css('img[src*="meditation-dog"]')
      expect(page).to_not have_css('img[src*="puppy-stretching"]')
    end

    it "Show the member's username" do
      sign_in @member
      visit member_posts_path(@lilly)
      expect(page).to have_content('Lilly')
      expect(page).to_not have_content('Luna')
    end

    it 'Shows the number of posts the member has written' do
      sign_in @member
      visit member_posts_path(@lilly)
      expect(page).to have_content('Number of posts: 2')
      expect(page).to_not have_content('Number of posts: 0')
    end

    it "Show a post's title" do
      sign_in @member
      visit member_posts_path(@lilly)
      expect(page).to have_content('Hello')
      expect(page).to have_content('Hey')
      expect(page).to_not have_content('Hi')
    end

    it "Show some of the post's body" do
      sign_in @member
      visit member_posts_path(@lilly)
      expect(page).to have_content('This is my first post')
      expect(page).to have_content('This is my second post')
      expect(page).to_not have_content('This is my third post')
    end

    it 'Show the first comments on a post' do
      sign_in @member
      visit member_posts_path(@lilly)
      expect(page).to have_content('First comment')
    end

    it 'Show how many comments a post has' do
      sign_in @member
      visit member_posts_path(@lilly)
      expect(page).to have_content('Comments: 5')
    end

    it 'Show how many likes a post has' do
      sign_in @member
      visit member_posts_path(@lilly)
      expect(page).to have_content('Likes: 3')
    end

    it 'Show a section for pagination if there are more posts than fit on the view' do
      sign_in @member
      visit member_posts_path(@lilly)
      expect(page).to have_content('Previous')
      expect(page).to have_content('Next')
    end

    it 'Show a section for pagination if there are more posts than fit on the view' do
      sign_in @member
      visit member_posts_path(@lilly)
      click_link 'Previous'
      expect(current_path).to eq member_posts_path(@lilly)
    end

    it "When I click on a post, it redirects me to that post's show page" do
      sign_in @member
      visit member_posts_path(@lilly)
      click_link 'Hello'
      expect(current_path).to eq member_post_path(@lilly, @hello)
    end
  end
end
