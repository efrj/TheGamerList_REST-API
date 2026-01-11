require 'swagger_helper'

RSpec.describe 'api/v1/authentication', type: :request do
  path '/api/v1/auth/register' do
    post('Registra um novo usuário') do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: ['name', 'email', 'password', 'password_confirmation']
      }

      response(201, 'successful') do
        schema type: :object,
          properties: {
            token: { type: :string },
            user: {
              type: :object,
              properties: {
                id: { type: :integer },
                name: { type: :string },
                email: { type: :string }
              }
            }
          }
        run_test!
      end

      response(422, 'unprocessable entity') do
        run_test!
      end
    end
  end

  path '/api/v1/auth/login' do
    post('Login') do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }

      response(200, 'successful') do
        schema type: :object,
          properties: {
            token: { type: :string },
            user: {
              type: :object,
              properties: {
                id: { type: :integer },
                name: { type: :string },
                email: { type: :string }
              }
            }
          }

        let(:credentials) { { email: 'user@example.com', password: 'password123' } }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:credentials) { { email: 'test@example.com', password: 'wrong' } }
        run_test!
      end
    end
  end

  path '/api/v1/auth/register' do
    post('Registra um novo usuário') do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: ['name', 'email', 'password', 'password_confirmation']
      }

      response(201, 'created') do
        schema type: :object,
          properties: {
            token: { type: :string },
            user: {
              type: :object,
              properties: {
                id: { type: :integer },
                name: { type: :string },
                email: { type: :string }
              }
            }
          }

        let(:auth) { { name: 'Test User', email: 'test@example.com', password: 'password123', password_confirmation: 'password123' } }
        run_test!
      end
    end
  end
end
