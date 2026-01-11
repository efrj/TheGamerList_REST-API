require 'swagger_helper'

RSpec.describe 'api/v1/softhouses', type: :request do
  path '/api/v1/softhouses' do
    get('Lista todas as desenvolvedoras') do
      tags 'Softhouses'
      produces 'application/json'
      
      response(200, 'successful') do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              description: { type: :string },
              created_at: { type: :string, format: :datetime },
              updated_at: { type: :string, format: :datetime }
            }
          }

        run_test!
      end
    end

    post('Cria uma nova desenvolvedora') do
      tags 'Softhouses'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :softhouse, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        },
        required: ['name']
      }

      response(201, 'created') do
        let(:softhouse) { { name: 'New Softhouse' } }
        run_test!
      end
    end
  end

  path '/api/v1/softhouses/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'ID da desenvolvedora'

    get('Mostra uma desenvolvedora específica') do
      tags 'Softhouses'
      produces 'application/json'
      
      response(200, 'successful') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :string },
            created_at: { type: :string, format: :datetime },
            updated_at: { type: :string, format: :datetime }
          }

        let(:id) { '1' }
        run_test!
      end
    end

    put('Atualiza uma desenvolvedora') do
      tags 'Softhouses'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :softhouse, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:id) { '1' }
        let(:softhouse) { { name: 'Updated Softhouse' } }
        run_test!
      end
    end

    delete('Remove uma desenvolvedora') do
      tags 'Softhouses'
      produces 'application/json'
      
      response(204, 'no content') do
        let(:id) { '1' }
        run_test!
      end
    end
  end
end
