require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  path '/api/v1/users/me' do
    get('Retorna dados do usuário autenticado') do
      tags 'Users'
      produces 'application/json'
      security [Bearer: []]
      
      parameter name: :Authorization, in: :header, type: :string, required: true, description: 'Bearer token'

      response(200, 'successful') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            email: { type: :string },
            created_at: { type: :string, format: :datetime }
          }

        let(:Authorization) { 'Bearer token123' }
        run_test!
      end

      response(401, 'unauthorized') do
        run_test!
      end
    end

    put('Atualiza dados do usuário autenticado') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]
      
      parameter name: :Authorization, in: :header, type: :string, required: true, description: 'Bearer token'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        }
      }

      response(200, 'successful') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            email: { type: :string }
          }

        let(:Authorization) { 'Bearer token123' }
        let(:user) { { name: 'Updated Name' } }
        run_test!
      end

      response(401, 'unauthorized') do
        run_test!
      end
    end
  end
end
