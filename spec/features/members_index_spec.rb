require 'rails_helper'

RSpec.describe 'Member index page', type: :feature do
  describe 'with FactoryBot login' do
    before(:each) do
      @member = FactoryBot.create(:member)
      @lilly = Member.create(name: 'Lilly', photo: 'https://c.tenor.com/YIeHLcvImMsAAAAM/meditation-dog.gif',
                             bio: 'Teacher from Poland', email: 'lilly@blog.com', password: 'password',
                             confirmed_at: Time.now)
      Post.create(author: @lilly, title: 'Hello', text: 'This is my first post')
      Post.create(author: @lilly, title: 'Hey', text: 'This is my second post')
    end

    it 'Show the member index view path' do
      sign_in @member
      visit root_path
      expect(page).to have_xpath('/')
    end

    it 'Show the username of all other members' do
      sign_in @member
      visit root_path
      expect(page).to have_content('Lilly')
      expect(page).to_not have_content('Luna')
    end

    it 'Shows the profile picture for each member' do
      sign_in @member
      visit root_path
      expect(page).to have_css('img[src*="meditation-dog"]')
      expect(page).to_not have_css('img[src*="puppy-stretching"]')
    end

    it 'Shows the number of posts each member has written' do
      sign_in @member
      visit root_path
      expect(page).to have_content('Number of posts: 2')
      expect(page).to_not have_content('Number of posts: 1')
    end

    it "When I click on a member, I am redirected to that member's show page" do
      sign_in @member
      visit root_path
      click_link 'Lilly'
      expect(current_path).to eq member_path(@lilly)
    end
  end

  describe 'Index page for Luna' do
    before(:each) do
      @member = FactoryBot.create(:member)
      @luna = Member.create(name: 'Luna', photo: 'https://c.tenor.com/JAWsyDUCa4QAAAAM/puppy-stretching.gif',
                            bio: 'Teacher from Brazil', email: 'luna@blog.com', password: 'password',
                            confirmed_at: Time.now)
      Post.create(author: @luna, title: 'Hi', text: 'This is my first post')
    end

    it 'Show the username of all other members' do
      sign_in @member
      visit root_path
      expect(page).to have_content('Luna')
      expect(page).to_not have_content('Lilly')
    end

    it 'Shows the profile picture for each member' do
      sign_in @member
      visit root_path
      expect(page).to have_css('img[src*="puppy-stretching"]')
      expect(page).to_not have_css('img[src*="meditation-dog"]')
    end

    it 'Shows the number of posts each member has written' do
      sign_in @member
      visit root_path
      expect(page).to have_content('Number of posts: 1')
      expect(page).to_not have_content('Number of posts: 2')
    end

    it "When I click on a member, I am redirected to that member's show page" do
      sign_in @member
      visit root_path
      click_link 'Luna'
      expect(current_path).to eq member_path(@luna)
    end
  end
end
