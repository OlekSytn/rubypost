require 'rails_helper'

RSpec.describe 'Members', type: :request do
  before(:each) do
    get root_path
  end
  describe 'GET /' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'render template members/index' do
      expect(response).to render_template('members/index')
    end
    it 'body include the placeholder "Here is a list of members"' do
      expect(response.body).to_not include('Here is a list of members')
    end
    it 'body include the path app/views/members/index.html.erb' do
      expect(response.body).to_not include('app/views/members/index.html.erb')
    end
  end

  describe 'GET /members' do
    before(:each) do
      get root_path
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'render template members/index' do
      expect(response).to render_template('members/index')
    end
    it 'body include the placeholder "Here is a list of members"' do
      expect(response.body).to_not include('Here is a list of members')
    end
    it 'body include the path app/views/members/index.html.erb' do
      expect(response.body).to_not include('app/views/members/index.html.erb')
    end
  end

  describe 'GET /members/1' do
    before(:each) do
      get member_path(1)
    end
    it 'returns http success' do
      expect(response).to_not have_http_status(:success)
    end
    it 'render template members/show' do
      expect(response).to_not render_template('members/show')
    end
    it 'body include the placeholder "Here is a detail for a given member"' do
      expect(response.body).to_not include('Here is a detail for a given member')
    end
    it 'body include the path app/views/members/show.html.erb' do
      expect(response.body).to_not include('app/views/members/show.html.erb')
    end
  end

  describe 'GET /members/index' do
    before(:each) do
      get root_path
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'not render template members/index' do
      expect(response).to render_template('members/index')
    end
    it 'render template members/show' do
      expect(response).to_not render_template('members/show')
    end
    it 'body include the path app/views/members/show.html.erb' do
      expect(response.body).to_not include('app/views/members/show.html.erb')
    end
  end

  describe 'GET /members/show' do
    before(:each) do
      get member_path(1)
    end
    it 'returns http success' do
      expect(response).to_not have_http_status(:success)
    end
    it 'render template members/show' do
      expect(response).to_not render_template('members/show')
    end
    it 'body include the placeholder "Here is a detail for a given member"' do
      expect(response.body).to_not include('Here is a detail for a given member')
    end
    it "body doesn't include the placeholder 'Here is a list of members'" do
      expect(response.body).to_not include('Here is a list of members')
    end
    it 'body include the path app/views/members/show.html.erb' do
      expect(response.body).to_not include('app/views/members/show.html.erb')
    end
  end
end
