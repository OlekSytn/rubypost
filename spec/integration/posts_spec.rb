require 'swagger_helper'

describe 'Posts' do
  path '/api/v1/members/{id}/posts' do
    get 'Retrieves posts' do
      security [{ ApiKeyAuth: [] }]
      tags 'Posts'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, required: true, description: 'member id'

      response '200', 'OK' do
        schema type: :object, properties: {
          id: { type: :integer },
          title: { type: :string },
          text: { type: :string },
          comments_counter: { type: :integer },
          likes_counter: { type: :integer },
          created_at: { type: :string },
          updated_at: { type: :string },
          author_id: { type: :integer }
        }
        let(:comments_counter) { 0 }
        run_test!
      end

      response '404', 'Not found' do
        let(:error) { 'Member/Post not found' }
        run_test!
      end
    end
  end

  path '/api/v1/members/{member_id}/posts/{id}' do
    get 'Retrieve a post' do
      security [{ ApiKeyAuth: [] }]
      tags 'Posts'
      produces 'application/json'
      parameter name: :member_id, in: :path, type: :string, required: true, description: 'member id'
      parameter name: :id, in: :path, type: :string, required: true, description: 'post id'

      response '200', 'OK' do
        schema type: :object, properties: {
          id: { type: :integer },
          title: { type: :string },
          text: { type: :string },
          comments_counter: { type: :integer },
          likes_counter: { type: :integer },
          created_at: { type: :string },
          updated_at: { type: :string },
          author_id: { type: :integer }
        }
        let(:comments_counter) { 0 }
        run_test!
      end

      response '404', 'Not found' do
        let(:error) { 'Member/Post not found' }
        run_test!
      end
    end
  end
end
