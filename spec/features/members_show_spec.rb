require 'rails_helper'

RSpec.describe 'Member show page', type: :feature do
  describe 'Show page for Lilly' do
    before(:each) do
      @member = FactoryBot.create(:member)
      @lilly = Member.create(name: 'Lilly', photo: 'https://c.tenor.com/YIeHLcvImMsAAAAM/meditation-dog.gif',
                             bio: 'Teacher from Poland', email: 'lilly@blog.com', password: 'password',
                             confirmed_at: Time.now)
      @hello = Post.create(author: @lilly, title: 'Hello', text: 'This is my first post')
      Post.create(author: @lilly, title: 'Hey', text: 'This is my second post')
    end

    it "Shows the member's profile picture" do
      sign_in @member
      visit member_path(@lilly)
      expect(page).to have_css('img[src*="meditation-dog"]')
      expect(page).to_not have_css('img[src*="puppy-stretching"]')
    end

    it "Show the member's username" do
      sign_in @member
      visit member_path(@lilly)
      expect(page).to have_content('Lilly')
      expect(page).to_not have_content('Luna')
    end

    it 'Shows the number of posts the member has written' do
      sign_in @member
      visit member_path(@lilly)
      expect(page).to have_content('Number of posts: 2')
      expect(page).to_not have_content('Number of posts: 0')
    end

    it "Show the member's bio" do
      sign_in @member
      visit member_path(@lilly)
      expect(page).to have_content('Teacher from Poland')
      expect(page).to_not have_content('Teacher from Brazil')
    end

    it "Show the member's first 3 posts" do
      sign_in @member
      visit member_path(@lilly)
      expect(page).to have_content('This is my first post')
      expect(page).to have_content('This is my second post')
      expect(page).to_not have_content("This is Luna's first post")
      expect(page).to have_content('Hello')
      expect(page).to have_content('Hey')
      expect(page).to_not have_content('Hi')
    end

    it "I can see a button that lets me view all of a member's posts" do
      sign_in @member
      visit member_path(@lilly)
      expect(page).to have_content('See all posts')
    end

    it "When I click a member's post, it redirects me to that post's show page" do
      sign_in @member
      visit member_path(@lilly)
      click_link 'Hello'
      expect(current_path).to eq member_post_path(@lilly, @hello)
    end

    it "When I click to see all posts, it redirects me to the member's post's index page" do
      sign_in @member
      visit member_path(@lilly)
      click_link 'See all posts'
      expect(current_path).to eq member_posts_path(@lilly)
    end
  end

  describe 'Show page for Luna' do
    before(:each) do
      @member = FactoryBot.create(:member)
      @luna = Member.create(name: 'Luna', photo: 'https://c.tenor.com/JAWsyDUCa4QAAAAM/puppy-stretching.gif',
                            bio: 'Teacher from Brazil', email: 'luna@blog.com', password: 'password',
                            confirmed_at: Time.now)
      Post.create(author: @luna, title: 'Hi one', text: "This is Luna's first post")
      Post.create(author: @luna, title: 'Hi two', text: "This is Luna's second post")
      @hi_three = Post.create(author: @luna, title: 'Hi three', text: "This is Luna's third post")
      Post.create(author: @luna, title: 'Hi four', text: "This is Luna's fourth post")
      Post.create(author: @luna, title: 'Hi five', text: "This is Luna's fifth post")
    end

    it "Shows the member's profile picture" do
      sign_in @member
      visit member_path(@luna)
      expect(page).to have_css('img[src*="puppy-stretching"]')
      expect(page).to_not have_css('img[src*="meditation-dog"]')
    end

    it "Show the member's username" do
      sign_in @member
      visit member_path(@luna)
      expect(page).to have_content('Luna')
      expect(page).to_not have_content('Lilly')
    end

    it 'Shows the number of posts the member has written' do
      sign_in @member
      visit member_path(@luna)
      expect(page).to have_content('Number of posts: 5')
      expect(page).to_not have_content('Number of posts: 0')
    end

    it "Show the member's bio" do
      sign_in @member
      visit member_path(@luna)
      expect(page).to have_content('Teacher from Brazil')
      expect(page).to_not have_content('Teacher from Poland')
    end

    it "Show the member's first 3 posts" do
      sign_in @member
      visit member_path(@luna)
      expect(page).to have_content("This is Luna's fifth post")
      expect(page).to have_content("This is Luna's fourth post")
      expect(page).to have_content("This is Luna's third post")
      expect(page).to_not have_content("This is Luna's second post")
      expect(page).to_not have_content("This is Luna's first post")
      expect(page).to have_content('Hi five')
      expect(page).to have_content('Hi four')
      expect(page).to have_content('Hi three')
      expect(page).to_not have_content('Hi two')
      expect(page).to_not have_content('Hi one')
    end

    it "I can see a button that lets me view all of a member's posts" do
      sign_in @member
      visit member_path(@luna)
      expect(page).to have_content('See all posts')
    end

    it "When I click a member's post, it redirects me to that post's show page" do
      sign_in @member
      visit member_path(@luna)
      click_link 'Hi three'
      expect(current_path).to eq member_post_path(@luna, @hi_three)
    end

    it "When I click to see all posts, it redirects me to the member's post's index page" do
      sign_in @member
      visit member_path(@luna)
      click_link 'See all posts'
      expect(current_path).to eq member_posts_path(@luna)
    end
  end
end
