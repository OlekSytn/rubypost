require 'swagger_helper'

describe 'Members' do
  path '/api/v1/members' do
    get 'Retrieves members' do
      tags 'Members'
      consumes 'application/json'

      response '200', 'OK' do
        schema type: :object, properties: {
          id: { type: :integer },
          name: { type: :string },
          bio: { type: :string },
          created_at: { type: :string },
          updated_at: { type: :string },
          photo: { type: :string },
          post_counter: { type: :integer },
          email: { type: :string },
          role: { type: :string }
        }
        let(:id) { 'valid' }
        run_test!
      end
    end
  end

  path '/api/v1/members/{id}' do
    get 'Retrieve a member' do
      security [{ ApiKeyAuth: [] }]
      tags 'Members'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, required: true, description: 'member id'

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 bio: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 photo: { type: :string },
                 post_counter: { type: :integer },
                 email: { type: :string },
                 role: { type: :string }
               }
        let(:id) { :id }
        run_test!
      end

      response '404', 'Not found' do
        let(:error) { 'Member not found' }
        run_test!
      end
    end
  end
end
